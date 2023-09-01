import { Injectable } from '@nestjs/common';
import { DataSource, Like } from 'typeorm';
import { Tag } from '../../entities/tag.entity';
import { TagDto } from '../../dtos/tag.dto';
import { randColor } from '@ngneat/falso';
import { TagIdentifierService } from './tag-identifier/tag-identifier.service';

@Injectable()
export class TagsService {
  constructor(
    readonly dataSource: DataSource,
    readonly identifierService: TagIdentifierService,
  ) {}

  async findAll(query: any): Promise<[Tag[], number]> {
    const limit = Number(query.limit ?? '25');
    const page = Number(query.page ?? '1');
    const search = query.search ?? '';

    const sort = query.sort ?? 'desc';

    let sort_by: any = { id: sort };
    switch (query.sort_by) {
      case 'type':
        sort_by = { type: sort };
        break;
      case 'name':
        sort_by = { name: sort };
        break;
      case 'training':
        sort_by = { training: sort };
      case 'desc':
        sort_by = { desc: sort };
      case 'isDeterminant':
        sort_by = { isDeterminant: sort };
        break;
        break;
      default:
        sort_by = { id: sort };
    }

    const [data, count] = await this.dataSource
      .getRepository(Tag)
      .findAndCount({
        select: [
          'id',
          'name',
          'type',
          'training',
          'canDetermine',
          'color',
          'isActive',
          'desc',
        ],
        where: [
          { name: Like('%' + search + '%') },
          { type: Like('%' + search + '%') },
          { desc: Like('%' + search + '%') },
        ],
        order: sort_by,
        take: limit,
        skip: limit * (page - 1),
      });
    return [data, count];
  }

  async findAllTypes(query: any): Promise<any[]> {
    return await this.dataSource
      .getRepository(Tag)
      .createQueryBuilder()
      .select('tag.type')
      .distinct(true)
      .getRawMany();
  }

  async find(id: number): Promise<Tag> {
    return await this.dataSource.getRepository(Tag).findOne({
      where: { id: id },
    });
  }

  async add(request: any, body: TagDto): Promise<Tag> {
    let tag = new Tag();
    tag.type = body.type;
    tag.name = body.name;
    tag.canDetermine = body.canDetermine;
    tag.color = randColor();
    tag.desc = body.desc;

    tag = await this.dataSource.getRepository(Tag).save(tag);
    if (body.identifiers == null || body.identifiers.length == 0) return tag;
    //
    const par: { utterances: string[]; tagId: number } = {
      tagId: tag.id,
      utterances: body.identifiers,
    };
    await this.identifierService.addAll(par);
    //
    return tag;
  }

  async addAll(request: any, bodies: TagDto[]): Promise<Tag[]> {
    const op = [];
    for (let i = 0; i < bodies.length; i++) {
      op.push(this.add(request, bodies[i]));
    }
    return Promise.all(op);
  }

  async edit(id: number, tagDto: TagDto): Promise<Tag> {
    let tag = await this.dataSource.getRepository(Tag).findOne({
      where: { id: id },
    });

    if (tagDto.name != null && tagDto.name != undefined) {
      tag.name = tagDto.name;
    }

    if (tagDto.canDetermine != null && tagDto.canDetermine != undefined) {
      tag.canDetermine = tagDto.canDetermine;
    }

    if (tagDto.isActive != null && tagDto.isActive != undefined) {
      tag.isActive = tagDto.isActive;
    }

    if (tagDto.type != null && tagDto.type != undefined) {
      tag.type = tagDto.type;
    }

    if (tagDto.desc != null && tagDto.desc != undefined) {
      tag.desc = tagDto.desc;
    }
    tag = await this.dataSource.getRepository(Tag).save(tag);

    if (tagDto.identifiers == null || tagDto.identifiers.length == 0)
      return tag;
    //
    const par: { utterances: string[]; tagId: number } = {
      tagId: tag.id,
      utterances: tagDto.identifiers,
    };
    await this.identifierService.deleteAllByTag(tag.id);
    await this.identifierService.addAll(par);
    //

    return tag;
  }

  async delete(id: number): Promise<any> {
    await this.identifierService.deleteAllByTag(id);
    return await this.dataSource.getRepository(Tag).delete({
      id: id,
    });
  }

  async deleteAll(ids: number[]): Promise<any> {
    const ops = [];
    ids.forEach((id) => ops.push(this.delete(id)));
    return await Promise.all(ops);
  }

  async clearAll(): Promise<any> {
    const ops = [];
    const tagIds = await this.dataSource.getRepository(Tag).find({
      select: ['id'],
    });
    tagIds.forEach((tag) => ops.push(this.delete(tag.id)));
    return await Promise.all(ops);
  }
}
