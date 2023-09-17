import { Injectable } from '@nestjs/common';
import { TagIdentifier } from '../../../entities/tag.identifier.entity';
import { DataSource, In } from 'typeorm';
import { Tag } from '../../../entities/tag.entity';

@Injectable()
export class TagIdentifierService {
  constructor(readonly dataSource: DataSource) {}

  async deleteAll(body: any): Promise<any> {
    return await this.dataSource
      .getRepository(TagIdentifier)
      .delete({ id: In(body.ids) });
  }

  async deleteAllByTag(tagId: number, lang: string | null): Promise<any> {
    const tag = await this.dataSource
      .getRepository(Tag)
      .findOneBy({ id: tagId });
    tag.training = 0;
    await this.dataSource.getRepository(Tag).save(tag);
    if (lang == null) {
      return await this.dataSource
        .getRepository(TagIdentifier)
        .delete({ tag: tag });
    } else {
      return await this.dataSource
        .getRepository(TagIdentifier)
        .delete({ language: lang, tag: tag });
    }
  }

  async delete(id: number): Promise<any> {
    return await this.dataSource
      .getRepository(TagIdentifier)
      .delete({ id: id });
  }

  async add(body: {
    tagId: number;
    utterance: string;
    language: string;
  }): Promise<TagIdentifier> {
    const tagIdentifier = new TagIdentifier();
    tagIdentifier.utterance = (body.utterance as string).replaceAll('\n', '');
    tagIdentifier.language = body.language;

    let newIdentifier = await this.dataSource
      .getRepository(TagIdentifier)
      .create(tagIdentifier);

    newIdentifier = await this.dataSource
      .getRepository(TagIdentifier)
      .save(newIdentifier);

    const tag = await this.dataSource
      .getRepository(Tag)
      .findOne({ where: { id: body.tagId } });
    tag.training = tag.training + 1;
    // tag.tagIdentifiers.push(newIdentifier);
    await this.dataSource.getRepository(Tag).save(tag);

    await this.dataSource
      .createQueryBuilder()
      .relation(Tag, 'tagIdentifiers')
      .of(tag.id)
      .add(newIdentifier.id);

    return newIdentifier;
  }

  async addAll(body: any): Promise<any> {
    if (body.tagId == undefined || body.tagId == null) {
      throw Error('Must provide tagId for bulk entry!');
    }

    if (
      body.utterances == undefined ||
      body.utterances == null ||
      !Array.isArray(body.utterances)
    ) {
      throw Error(
        'Must provide utterances as an array of strings for bulk entry!',
      );
    }

    const ops = [];
    if (body.clear) await this.deleteAllByTag(body.tagId, body.language);
    body.utterances.forEach((utterance) => {
      if (utterance != null && (utterance as string).trim().length > 0) {
        ops.push(
          this.add({
            tagId: body.tagId,
            utterance: utterance,
            language: body.language,
          }),
        );
      }
    });

    return await Promise.all(ops);
  }

  async findAll(request: any, tagId: number): Promise<TagIdentifier[]> {
    const lang = request.query.language ?? 'en';
    const tag = await this.dataSource
      .getRepository(Tag)
      .findOneBy({ id: tagId });
    return await this.dataSource.getRepository(TagIdentifier).find({
      where: { tag: tag, language: lang },
      order: { id: 'DESC' },
    });
  }
}
