import { Tag } from '../entities/tag.entity';
import { TagIdentifier } from '../entities/tag.identifier.entity';

export class TagDto {
  name: string;

  type: string;

  desc: string;

  canDetermine: boolean;

  identifiers: string[];

  isActive?: boolean;

  constructor(data: any) {
    if (data == null) return;

    if (data.canDetermine != null) this.canDetermine = data.canDetermine;
    else this.canDetermine = false;
    if (data.type != null) this.type = data.type;
    if (data.isActive != null) this.isActive = data.isActive;
    if (data.desc != null) this.desc = data.desc;
    if (data.name != null) this.name = data.name;
    if (data.identifiers != null) this.identifiers = data.identifiers;
  }

  static from(entity: Tag): TagDto {
    const dto = new TagDto(null);
    dto.name = entity.name;
    dto.type = entity.type;
    dto.desc = entity.desc;
    dto.isActive = entity.isActive;
    dto.identifiers = entity.tagIdentifiers?.map((ti) => ti.utterance);
    dto.canDetermine = entity.canDetermine;
    return dto;
  }
}
