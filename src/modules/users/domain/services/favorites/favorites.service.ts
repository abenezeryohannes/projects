import { Injectable } from '@nestjs/common';
import { Favorite } from '../../entities/favorite.entity';
import { DataSource } from 'typeorm';
import { Company } from '../../../../companies/domain/entities/company.entity';
import { User } from '../../entities/user.entity';

@Injectable()
export class FavoritesService {
  constructor(readonly dataSource: DataSource) {}

  async unSet(request: any, id: number): Promise<boolean> {
    const favorite = await this.dataSource
      .getRepository(Favorite)
      .findOne({ where: { id: id }, relations: ['company'] });

    await this.dataSource
      .getRepository(Favorite)
      .createQueryBuilder()
      .delete()
      .where('id = :id', { id: id })
      .execute();

    const company = await this.dataSource
      .getRepository(Company)
      .findOneBy({ id: favorite.company.id });
    if (company.liked > 0) company.liked--;
    await this.dataSource.getRepository(Company).save(company);
    return true;
  }

  async set(request: any, company_id: number): Promise<Favorite> {
    const favorite = new Favorite();
    favorite.user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });

    await this.dataSource
      .getRepository(Favorite)
      .createQueryBuilder()
      .delete()
      .where('companyID = :companyID AND userID = :userID', {
        companyID: company_id,
        userID: request.user.id,
      })
      .execute();

    favorite.company = await this.dataSource
      .getRepository(Company)
      .findOne({ where: { id: company_id } });

    if (favorite.company == null)
      throw new Error('No company with this id found !!');

    await this.dataSource.manager.save(favorite);

    const company = await this.dataSource
      .getRepository(Company)
      .findOneBy({ id: company_id });
    company.liked++;
    await this.dataSource.getRepository(Company).save(company);

    return favorite;
  }

  async findAll(request: any): Promise<Favorite[]> {
    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });
    return this.dataSource.getRepository(Favorite).find({
      where: { user: user },
      relations: ['company', 'user'],
    });
  }

  async find(user_id: number, company_id: number): Promise<Favorite> {
    const company = await this.dataSource
      .getRepository(Company)
      .findOneBy({ id: company_id });

    const user = await this.dataSource
      .getRepository(User)
      .findOneBy({ id: user_id });

    const result = await this.dataSource.getRepository(Favorite).findOneBy({
      user: user,
      company: company,
    });
    return result;
  }
}
