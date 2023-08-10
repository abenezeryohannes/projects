import { Tag } from '../entities/tag.entity';

export class TagDto {
  name: string;

  type: string;

  desc: string;

  canDetermine: boolean;

  constructor(data: any) {
    if (data == null) return;

    if (data.canDetermine != null) this.canDetermine = data.canDetermine;
    else this.canDetermine = false;
    if (data.type != null) this.type = data.type;
    if (data.desc != null) this.desc = data.desc;
    if (data.name != null) this.name = data.name;
  }

  static from(entity: Tag): TagDto {
    const dto = new TagDto(null);
    dto.name = entity.name;
    dto.type = entity.type;
    dto.desc = entity.desc;
    dto.canDetermine = entity.canDetermine;
    return dto;
  }

  static toEntity(dto: TagDto): Tag {
    const entity = new Tag();
    entity.type = dto.type;
    entity.name = dto.name;
    entity.desc = dto.desc;
    entity.canDetermine = dto.canDetermine;
    return entity;
  }
}
