import { Company } from '../entities/company.entity';

export class CompanyDto {
  id: number;

  name: string;

  userId: number;

  banner: string;

  phoneNumber: string;

  ownerPhoneNumber: string;

  deliverTime: string;

  deliveryFee: string;

  isActive: boolean;

  tags: string[];

  constructor(data: any) {
    if (data == null) return;

    if (data.name != null) this.name = data.name;
    if (data.id != null) this.id = data.id;
    if (data.userId != null) this.userId = data.userId;
    if (data.banner != null) this.banner = data.banner;
    if (data.phoneNumber != null) this.phoneNumber = data.phoneNumber;
    if (data.ownerPhoneNumber != null)
      this.ownerPhoneNumber = data.ownerPhoneNumber;
    if (data.deliverTime != null) this.deliverTime = data.deliverTime;
    if (data.deliveryFee != null) this.deliveryFee = data.deliveryFee;
    if (data.isActive != null) this.isActive = data.isActive;
    if (data.tags != null)
      this.tags =
        typeof data.tags == 'string' ? JSON.parse(data.tags) : data.tags;
  }

  static from(entity: Company): CompanyDto {
    const dto = new CompanyDto(null);
    dto.id = entity.id;
    dto.name = entity.name;
    dto.userId = entity.userId;
    dto.banner = entity.banner;
    dto.ownerPhoneNumber = entity.ownerPhoneNumber;
    dto.deliverTime = entity.deliverTime;
    dto.deliveryFee = entity.deliveryFee;
    dto.phoneNumber = entity.phoneNumber;
    dto.isActive = entity.isActive;
    return dto;
  }

  static toEntity(dto: CompanyDto): Company {
    const entity = new Company();
    entity.id = dto.id;
    entity.name = dto.name;
    entity.userId = dto.userId;
    entity.banner = dto.banner;
    entity.phoneNumber = dto.phoneNumber;
    entity.ownerPhoneNumber = dto.ownerPhoneNumber;
    entity.deliverTime = dto.deliverTime;
    entity.deliveryFee = dto.deliveryFee;
    entity.isActive = dto.isActive;
    return entity;
  }
}
