import { User } from '../entities/user.entity';

export class UserDto {
  id: number;

  UID: string;

  avatar: string;

  fullName: string;

  phoneNumber: string;

  role: string;

  language: string;

  theme: string;

  isActive: boolean;

  constructor(data: any) {
    if (data == null) return;

    if (data.id != null) this.id = data.id;
    if (data.UID != null) this.UID = data.UID;
    if (data.fullName != null) this.fullName = data.fullName;
    if (data.phoneNumber != null) this.phoneNumber = data.phoneNumber;
    if (data.role != null) this.role = data.role;
    if (data.language != null) this.language = data.language;
    if (data.theme != null) this.theme = data.theme;
    if (data.isActive != null) this.isActive = data.isActive;
    if (data.avatar != null) this.avatar = data.avatar;
  }

  static from(entity: User): UserDto {
    const dto = new UserDto(null);
    dto.id = entity.id;
    dto.UID = entity.UID;
    dto.fullName = entity.fullName;
    dto.phoneNumber = entity.phoneNumber;
    dto.role = entity.role;
    dto.language = entity.language;
    dto.theme = entity.theme;
    dto.isActive = entity.isActive;
    dto.avatar = entity.avatar;
    return dto;
  }

  static toEntity(dto: UserDto): User {
    const entity = new User();
    entity.id = dto.id;
    entity.UID = dto.UID;
    entity.fullName = dto.fullName;
    entity.phoneNumber = dto.phoneNumber;
    entity.role = dto.role;
    entity.language = dto.language;
    entity.theme = dto.theme;
    entity.isActive = dto.isActive;
    entity.avatar = dto.avatar;
    return entity;
  }
}
