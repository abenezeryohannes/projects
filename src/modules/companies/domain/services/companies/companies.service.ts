import { Injectable } from '@nestjs/common';
import { CompanyDto } from '../../dtos/company.dto';
import { DataSource, In } from 'typeorm';
import { Company } from '../../entities/company.entity';
import { join } from 'path';
import { Tag } from '../../entities/tag.entity';

@Injectable()
export class CompaniesService {
  constructor(readonly dataSource: DataSource) {}

  async findAll(): Promise<Company[]> {
    return this.dataSource.getRepository(Company).find();
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

  async findOne(id: number): Promise<Company> | null {
    return this.dataSource
      .getRepository(Company)
      .findOne({ where: { id: id } });
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

    if (companyDto.deliverTime != null && companyDto.deliverTime != undefined) {
      company.deliverTime = companyDto.deliverTime;
    }

    if (companyDto.deliveryFee != null && companyDto.deliveryFee != undefined) {
      company.deliveryFee = companyDto.deliveryFee;
    }

    if (companyDto.name != null && companyDto.name != undefined) {
      company.name = companyDto.name;
    }

    if (companyDto.phoneNumber != null && companyDto.phoneNumber != undefined) {
      company.phoneNumber = companyDto.phoneNumber;
    }

    if (
      companyDto.ownerPhoneNumber != null &&
      companyDto.ownerPhoneNumber != undefined
    ) {
      company.ownerPhoneNumber = companyDto.ownerPhoneNumber;
    }

    if (request.file != null)
      company.banner = join('public', request.file.filename);
    await this.dataSource.getRepository(Company).save(company);
    //tags
    //get already saved tags
    // const st: Tag[] = await this.dataSource
    //   .getRepository(Tag)
    //   .createQueryBuilder()
    //   .where('id IN(:...names)', {
    //     names: companyDto.tags.map((t) => t.toLowerCase()),
    //   })
    //   .execute();
    // const savedTags = st.map((st) => st.name.toLowerCase());
    // //filter not saved new tags
    // const newTags: string[] = companyDto.tags.filter((t) =>
    //   savedTags.includes(t.toLowerCase()),
    // );
    // //add the new tags
    // await Promise.all(
    //   newTags.map(async (name) => {
    //     const tag = new Tag();
    //     tag.name = name;
    //     tag.user = request.user;
    //     tag.isDefault = false;
    //     tag.color = Util.randomColor();
    //     tag.companies = [company];
    //     await this.dataSource.getRepository(Tag).create(tag);
    //   }),
    // );

    return company;
  }

  async add(request: any, companyDto: CompanyDto): Promise<Company> {
    let company = CompanyDto.toEntity(companyDto);

    company.userId = request.user.id;
    company.isActive = false;

    if (request.file != null)
      company.banner = join('public', request.file.filename);

    company = await this.dataSource.getRepository(Company).save(company);
    // tags
    // get already saved tags
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
    // const savedTags: string[] = stt.map((s) => s.name.toLowerCase());
    // //filter not saved new tags
    // const newTags: string[] = companyDto.tags.filter(
    //   (t) => !savedTags.includes(t.toLowerCase()),
    // );

    // //
    // // add the new tags
    // if (newTags.length > 0) {
    //   const user = await this.dataSource
    //     .getRepository(User)
    //     .findOne({ where: { id: request.user.id } });

    //   const nTs: Tag[] = newTags.map((name) => {
    //     const tag = new Tag();
    //     tag.name = name;
    //     tag.isDefault = false;
    //     tag.color = Util.randomColor();
    //     tag.companies = [company];
    //     return tag;
    //   });

    //   const nTs = await this.dataSource.manager.save(tags);

    //   const newTagsSaved = await this.dataSource.getRepository(Tag).find({
    //     where: {
    //       id: In(nTs.map((x) => x.id)),
    //     },
    //   });
    //   company.tags = company.tags.concat(newTagsSaved);
    // }

    return await this.dataSource.getRepository(Company).save(company);
  }
}
