import { Injectable } from '@nestjs/common';
import { Favorite } from '../../entities/favorite.entity';
import { DataSource } from 'typeorm';
import { Company } from '../../../../companies/domain/entities/company.entity';
import { User } from '../../entities/user.entity';

@Injectable()
export class FavoritesService {
  constructor(readonly dataSource: DataSource) {}

  async unSet(request: any, id: number): Promise<boolean> {
    await this.dataSource
      .getRepository(Favorite)
      .createQueryBuilder()
      .delete()
      .where('id = :id', { id: id })
      .execute();
    return true;
  }

  async set(request: any, company_id: number): Promise<Favorite> {
    const favorite = new Favorite();
    favorite.user = request.user;

    favorite.company = await this.dataSource
      .getRepository(Company)
      .findOne({ where: { id: company_id } });

    if (favorite.company == null)
      throw new Error('No company with this id found !!');

    await this.dataSource.manager.save(favorite);
    return favorite;
  }

  async findAll(request: any): Promise<Favorite[]> {
    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });
    return this.dataSource.getRepository(Favorite).find({
      where: { user: user },
      relations: ['company'],
    });
  }
}
