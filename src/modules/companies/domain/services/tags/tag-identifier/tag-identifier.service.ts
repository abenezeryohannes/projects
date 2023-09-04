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

  async deleteAllByTag(tagId: number): Promise<any> {
    const tag = await this.dataSource
      .getRepository(Tag)
      .findOneBy({ id: tagId });
    tag.training = 0;
    await this.dataSource.getRepository(Tag).save(tag);
    return await this.dataSource
      .getRepository(TagIdentifier)
      .delete({ tag: tag });
  }

  async delete(id: number): Promise<any> {
    return await this.dataSource
      .getRepository(TagIdentifier)
      .delete({ id: id });
  }

  async add(body: any): Promise<TagIdentifier> {
    const tagIdentifier = new TagIdentifier();
    tagIdentifier.tag = await this.dataSource
      .getRepository(Tag)
      .findOneBy({ id: body.tagId });
    if (tagIdentifier.tag == null) {
      throw Error('No tag with id: ' + body.tagId);
    }
    tagIdentifier.utterance = body.utterance;

    const tag = await this.dataSource
      .getRepository(Tag)
      .findOneBy({ id: body.tagId });
    tag.training = tag.training + 1;
    await this.dataSource.getRepository(Tag).save(tag);

    return this.dataSource.getRepository(TagIdentifier).save(tagIdentifier);
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
    const obj = { tagId: Number, utterance: String };
    if (body.clear) await this.deleteAllByTag(body.tagId);
    body.utterances.forEach((utterance) => {
      obj.tagId = body.tagId;
      obj.utterance = utterance;
      ops.push(this.add(obj));
    });

    return await Promise.all(ops);
  }

  async findAll(tagId: number): Promise<TagIdentifier[]> {
    const tag = await this.dataSource
      .getRepository(Tag)
      .findOneBy({ id: tagId });
    return await this.dataSource.getRepository(TagIdentifier).find({
      where: { tag: tag },
    });
  }
}
