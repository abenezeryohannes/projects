import { Injectable } from '@nestjs/common';
import { CompanyDto } from '../../dtos/company.dto';
import { DataSource, In, Like } from 'typeorm';
import { Company } from '../../entities/company.entity';
import { join } from 'path';
import { Tag } from '../../entities/tag.entity';
import { TagIdentifier } from '../../entities/tag.identifier.entity';

@Injectable()
export class CompaniesService {
  constructor(readonly dataSource: DataSource) {}

  async findAll(request: any, query: any): Promise<[Company[], number]> {
    const limit = Number(query.limit ?? '25');
    const page = Number(query.page ?? '1');
    const search = query.search ?? '';

    const sort = query.sort ?? 'desc';

    let sort_by: any = { id: sort };
    switch (query.sort_by) {
      case 'like':
        sort_by = { like: sort };
        break;
      case 'name':
        sort_by = { name: sort };
        break;
      case 'arabicName':
        sort_by = { arabicName: sort };
        break;
      case 'phoneNumber':
        sort_by = { phoneNumber: sort };
        break;
      case 'deliveryFee':
        sort_by = { deliveryFee: sort };
        break;
      case 'deliveryTime':
        sort_by = { deliveryTime: sort };
        break;
      case 'badge':
        sort_by = { badge: sort };
        break;
      case 'badgeColor':
        sort_by = { badgeColor: sort };
        break;
      default:
        sort_by = { id: sort };
    }

    const [data, count] = await this.dataSource
      .getRepository(Company)
      .findAndCount({
        where: [
          {
            name: Like('%' + search + '%'),
            isActive: request.user.role != 'ADMIN' ? true : In([true, false]),
          },
          {
            deliveryFee: Like('%' + search + '%'),
            isActive: request.user.role != 'ADMIN' ? true : In([true, false]),
          },
          {
            deliveryTime: Like('%' + search + '%'),
            isActive: request.user.role != 'ADMIN' ? true : In([true, false]),
          },
        ],
        order: sort_by,
        take: limit,
        skip: limit * (page - 1),
      });
    return [data, count];
  }

  async findWithIds(request: any): Promise<any> {
    const limit = request.query.limit ?? 5;
    const page = request.query.page ?? 1;
    const id = request.query.id ?? -1;
    const ids = JSON.parse(request.query.ids) ?? [];

    const [chats, count] = await this.dataSource
      .getRepository(Company)
      .findAndCount({
        where: { id: In(ids) },
        take: limit,
        order: {
          liked: 'DESC',
        },
        skip: id > 0 ? 0 : limit * (page - 1),
      });

    return {
      datas: chats,
      count: count,
    };
  }

  async get(request: any): Promise<Company[]> {
    return this.dataSource
      .getRepository(Company)
      .find({ where: { user: request.user } });
  }

  async deleteAll(ids: number[]): Promise<any> {
    const ops = [];
    ids.forEach((id) => ops.push(this.delete(id)));
    return await Promise.all(ops);
  }

  async delete(id: number): Promise<any> {
    const company = await this.dataSource.getRepository(Company).findOne({
      where: { id: id },
    });

    // await this.dataSource.getRepository(Tag).delete({
    //   companies: [company],
    // });

    return await this.dataSource.getRepository(Company).remove(company);
  }

  async findOne(id: number): Promise<Company> | null {
    return this.dataSource
      .getRepository(Company)
      .findOne({ where: { id: id }, relations: ['tags'] });
  }

  async edit(
    request: any,
    id: number,
    companyDto: CompanyDto,
  ): Promise<Company> {
    const company = await this.dataSource
      .getRepository(Company)
      .findOne({ where: { id: id } });

    if (company == null) throw new Error('Sorry, Company not found to edit!');

    if (
      companyDto.deliveryTime != null &&
      companyDto.deliveryTime != undefined
    ) {
      company.deliveryTime = companyDto.deliveryTime;
    }

    if (companyDto.arabicName != null && companyDto.arabicName != undefined) {
      company.arabicName = companyDto.arabicName;
    }

    if (companyDto.badge != null && companyDto.badge != undefined) {
      company.badge = companyDto.badge;
    }

    if (companyDto.badgeColor != null && companyDto.badgeColor != undefined) {
      company.badgeColor = companyDto.badgeColor;
    }

    if (companyDto.deliveryFee != null && companyDto.deliveryFee != undefined) {
      company.deliveryFee = companyDto.deliveryFee;
    }

    if (
      companyDto.deliveryTime != null &&
      companyDto.deliveryTime != undefined
    ) {
      company.deliveryTime = companyDto.deliveryTime;
    }

    if (companyDto.name != null && companyDto.name != undefined) {
      company.name = companyDto.name;
    }

    if (companyDto.phoneNumber != null && companyDto.phoneNumber != undefined) {
      company.phoneNumber = companyDto.phoneNumber;
    }

    if (companyDto.isActive != null && companyDto.isActive != undefined) {
      company.isActive = companyDto.isActive;
      this.train(company);
    }

    if (
      companyDto.ownerPhoneNumber != null &&
      companyDto.ownerPhoneNumber != undefined
    ) {
      company.ownerPhoneNumber = companyDto.ownerPhoneNumber;
    }

    if (companyDto.tags != null && companyDto.tags != undefined) {
      const tags = await this.dataSource.getRepository(Tag).find({
        where: { id: In(companyDto.tags?.map((s) => Number.parseInt(s))) },
      });
      company.tags = tags;
    }

    if (request.file != null)
      company.banner = join('public', request.file.filename);
    await this.dataSource.getRepository(Company).save(company);

    return company;
  }

  async add(request: any, companyDto: CompanyDto): Promise<Company> {
    let company: Company = CompanyDto.toEntity(companyDto);

    company.userId = request.user.id;
    company.isActive = companyDto.isActive;

    if (request.file != null)
      company.banner = join('public', request.file.filename);

    company = await this.dataSource.getRepository(Company).save(company);
    this.train(company);
    // tags
    // get already saved tags
    if (
      companyDto.tags != undefined &&
      companyDto.tags != null &&
      companyDto.tags.length > 0
    ) {
      const st = await this.dataSource
        .getRepository(Tag)
        .createQueryBuilder()
        .where('LOWER(name) IN(:...names)', {
          names: companyDto.tags.map((t) => t.toLowerCase()),
        })
        .execute();

      const stt = await this.dataSource.getRepository(Tag).find({
        where: {
          id: In(st.map((x) => x.Tag_id)),
        },
      });

      company.tags = stt;
      return await this.dataSource.getRepository(Company).save(company);
    }
    return company;
  }

  async train(company: Company) {
    if (company.isActive) {
      let tag = new Tag();
      tag.arabicName = company.name;
      tag.name = company.name;
      tag.desc = `Tag for ${company.name}`;
      tag.type = 'Business Name';
      tag.canDetermine = true;
      tag.color = '#FFFFFF';
      tag = await this.dataSource.getRepository(Tag).save(tag);
      let tagIdentifier = new TagIdentifier();
      tagIdentifier.language = 'en';
      tagIdentifier.tag = tag;
      tagIdentifier.utterance = company.name;
      tagIdentifier = await this.dataSource
        .getRepository(TagIdentifier)
        .save(tagIdentifier);
      let tagIdentifier2 = new TagIdentifier();
      tagIdentifier2.language = 'ar';
      tagIdentifier2.tag = tag;
      tagIdentifier2.utterance = company.name;
      tagIdentifier2 = await this.dataSource
        .getRepository(TagIdentifier)
        .save(tagIdentifier2);
    } else {
      const tag = await this.dataSource
        .getRepository(Tag)
        .findOne({ where: { name: company.name } });
      await this.dataSource.getRepository(TagIdentifier).delete({ tag: tag });
      await this.dataSource.getRepository(Tag).delete({ name: tag.name });
    }
  }
}
