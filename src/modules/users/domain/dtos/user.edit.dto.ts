import { User } from '../entities/user.entity';

export class UserEditDto {
  UID: string;

  avatar: string;

  fullName: string;

  language: string;

  theme: string;

  isActive: boolean;

  constructor(data: any) {
    if (data == null) return;

    if (data.UID != null) this.UID = data.UID;
    if (data.fullName != null) this.fullName = data.fullName;
    if (data.language != null) this.language = data.language;
    if (data.theme != null) this.theme = data.theme;
    if (data.isActive != null) this.isActive = data.isActive;
    if (data.avatar != null) this.avatar = data.avatar;
  }

  static from(entity: User): UserEditDto {
    const dto = new UserEditDto(null);
    dto.UID = entity.UID;
    dto.fullName = entity.fullName;
    dto.language = entity.language;
    dto.theme = entity.theme;
    dto.isActive = entity.isActive;
    dto.avatar = entity.avatar;
    return dto;
  }

  static toEntity(dto: UserEditDto): User {
    const entity = new User();
    entity.UID = dto.UID;
    entity.fullName = dto.fullName;
    entity.language = dto.language;
    entity.theme = dto.theme;
    entity.isActive = dto.isActive;
    entity.avatar = dto.avatar;
    return entity;
  }
}
