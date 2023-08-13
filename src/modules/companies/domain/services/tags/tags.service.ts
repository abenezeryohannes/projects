import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { Tag } from '../../entities/tag.entity';
import { TagDto } from '../../dtos/tag.dto';
import { randColor } from '@ngneat/falso';

@Injectable()
export class TagsService {
  constructor(readonly dataSource: DataSource) {}

  async findAll(): Promise<Tag[]> {
    return this.dataSource.getRepository(Tag).find({
      select: ['id', 'name', 'type', 'canDetermine', 'color', 'isActive'],
    });
  }

  async add(request: any, body: TagDto): Promise<Tag> {
    const tag = new Tag();
    tag.type = body.type;
    tag.name = body.name;
    tag.canDetermine = body.canDetermine;
    tag.color = randColor();
    tag.desc = body.desc;
    return await this.dataSource.getRepository(Tag).save(tag);
  }

  async addAll(request: any, bodies: TagDto[]): Promise<Tag[]> {
    const op = [];
    for (let i = 0; i < bodies.length; i++) {
      op.push(this.add(request, bodies[i]));
    }
    return Promise.all(op);
  }
}
