import { Company } from '../entities/company.entity';

export class CompanyDto {
  id: number;

  name: string;

  arabicName: string;

  userId: number;

  banner: string;

  url: string;

  phoneNumber: string;

  ownerPhoneNumber: string;

  deliveryTime: string;

  deliveryFee: string;

  isActive: boolean;

  badge: string;

  badgeColor: string;

  tags: string[];

  constructor(data: any) {
    if (data == null) return;
    if (data.name != null) this.name = data.name;
    if (data.arabicName != null) this.arabicName = data.arabicName;
    if (data.url != null) this.url = data.url;
    if (data.id != null) this.id = data.id;
    if (data.userId != null) this.userId = data.userId;
    if (data.banner != null) this.banner = data.banner;
    if (data.phoneNumber != null) this.phoneNumber = data.phoneNumber;
    if (data.ownerPhoneNumber != null)
      this.ownerPhoneNumber = data.ownerPhoneNumber;
    if (data.deliveryTime != null) this.deliveryTime = data.deliveryTime;
    if (data.deliveryFee != null) this.deliveryFee = data.deliveryFee;
    if (data.isActive != null) this.isActive = data.isActive;
    else data.isActive = false;
    if (data.badge != null) this.badge = data.badge;
    if (data.badgeColor != null) this.badgeColor = data.badgeColor;
    if (data.tags != null)
      this.tags =
        typeof data.tags == 'string' ? JSON.parse(data.tags) : data.tags;
  }

  static from(entity: Company): CompanyDto {
    const dto = new CompanyDto(null);
    dto.id = entity.id;
    dto.name = entity.name;
    dto.arabicName = entity.arabicName;
    dto.url = entity.url;
    dto.userId = entity.userId;
    dto.banner = entity.banner;
    dto.ownerPhoneNumber = entity.ownerPhoneNumber;
    dto.deliveryTime = entity.deliveryTime;
    dto.deliveryFee = entity.deliveryFee;
    dto.phoneNumber = entity.phoneNumber;
    dto.badge = entity.badge;
    dto.badgeColor = entity.badgeColor;
    dto.isActive = entity.isActive;
    return dto;
  }

  static toEntity(dto: CompanyDto): Company {
    const entity = new Company();
    entity.id = dto.id;
    entity.name = dto.name;
    entity.arabicName = dto.arabicName;
    entity.userId = dto.userId;
    entity.banner = dto.banner;
    entity.url = dto.url;
    entity.phoneNumber = dto.phoneNumber;
    entity.ownerPhoneNumber = dto.ownerPhoneNumber;
    entity.deliveryTime = dto.deliveryTime;
    entity.deliveryFee = dto.deliveryFee;
    entity.isActive = dto.isActive;
    entity.badge = dto.badge;
    entity.badgeColor = dto.badgeColor;
    if (entity.arabicName == null) entity.arabicName = entity.name;
    return entity;
  }
}
