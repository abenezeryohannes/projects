import { Injectable } from '@nestjs/common';
import { Between, DataSource, In, IsNull, LessThan, Like } from 'typeorm';
import { User } from '../../../users/domain/entities/user.entity';
import { Session } from '../../../users/domain/entities/session.entity';
import * as moment from 'moment';
import { Chat } from '../../../chats/domain/entities/chat.entity';
import { Company } from '../../../companies/domain/entities/company.entity';
import { Tag } from '../../../companies/domain/entities/tag.entity';

@Injectable()
export class AnalyticsService {
  //
  constructor(readonly dataSource: DataSource) {}
  //
  //
  //
  async findNewBusinesses(
    request: any,
    query: any,
  ): Promise<[Company[], number]> {
    const limit = Number(query.limit ?? '25');
    const page = Number(query.page ?? '1');
    const search = query.search ?? '';
    const start = new Date(query.start ?? '2023-01-01');
    const end = new Date(query.end ?? '2050-01-01');

    const sort_by: any = { id: 'desc' };

    const [data, count] = await this.dataSource
      .getRepository(Company)
      .findAndCount({
        where: [
          {
            name: Like('%' + search + '%'),
            createdAt: Between(start, end),
            // isActive: false,
          },
          {
            deliveryFee: Like('%' + search + '%'),
            createdAt: Between(start, end),
            // isActive: false,
          },
          {
            deliveryTime: Like('%' + search + '%'),
            createdAt: Between(start, end),
            // isActive: false,
          },
        ],
        relations: ['tags'],
        order: sort_by,
        take: limit,
        skip: limit * (page - 1),
      });
    return [data, count];
  }
  //
  //
  //
  async findClickedBusiness(
    request: any,
    query: any,
  ): Promise<[Company[], number]> {
    const limit = Number(query.limit ?? '25');
    const page = Number(query.page ?? '1');
    const search = query.search ?? '';
    const sort_by: any = { clicked: 'desc' };
    const start = new Date(query.start ?? '2023-01-01');
    const end = new Date(query.end ?? '2050-01-01');

    const [data, count] = await this.dataSource
      .getRepository(Company)
      .findAndCount({
        where: [
          {
            name: Like('%' + search + '%'),
            createdAt: Between(start, end),
            isActive: true,
          },
          {
            deliveryFee: Like('%' + search + '%'),
            createdAt: Between(start, end),
            isActive: true,
          },
          {
            deliveryTime: Like('%' + search + '%'),
            createdAt: Between(start, end),
            isActive: true,
          },
        ],
        order: sort_by,
        take: limit,
        skip: limit * (page - 1),
      });
    return [data, count];
  }
  //
  //
  //
  async findMostSearchedTags(
    request: any,
    query: any,
  ): Promise<[Tag[], number]> {
    const limit = Number(query.limit ?? '25');
    const page = Number(query.page ?? '1');

    const [data, count] = await this.dataSource
      .getRepository(Tag)
      .findAndCount({
        where: [],
        order: { searchCount: 'DESC' },
        take: limit,
        skip: limit * (page - 1),
      });
    return [data, count];
  }
  ///
  async totalNewBusinesses(request: any, query: any): Promise<any> {
    //
    const start = new Date(query.start ?? '2023-01-01');
    const end = new Date(query.end ?? '2050-01-01');

    const result = await this.dataSource.getRepository(Company).count({
      where: {
        isActive: false,
        createdAt: Between(start, end),
      },
    });

    const yesterday = await this.dataSource.getRepository(Company).count({
      where: {
        isActive: false,
        createdAt: LessThan(start),
      },
    });

    const total = await this.dataSource.getRepository(Company).count({
      where: {
        isActive: false,
      },
    });

    return {
      today: result,
      yesterday: yesterday,
      total: total,
    };
  }
  //
  async totalStores(request: any, query: any): Promise<any> {
    //
    const start = new Date(query.start ?? '2023-01-01');
    const end = new Date(query.end ?? '2050-01-01');

    const result = await this.dataSource.getRepository(Company).count({
      where: {
        createdAt: Between(start, end),
      },
    });

    const yesterday = await this.dataSource.getRepository(Company).count({
      where: {
        createdAt: LessThan(start),
      },
    });

    const total = await this.dataSource.getRepository(Company).count({
      where: {},
    });

    return {
      today: result,
      yesterday: yesterday,
      total: total,
    };
  }
  //
  //
  //
  async totalUsers(request: any, query: any): Promise<any> {
    //
    const start = new Date(query.start ?? '2023-01-01');
    const end = new Date(query.end ?? '2050-01-01');

    const result = await this.dataSource.getRepository(User).count({
      where: {
        createdAt: Between(start, end),
      },
    });

    const yesterday = await this.dataSource.getRepository(User).count({
      where: {
        createdAt: LessThan(start),
      },
    });

    const total = await this.dataSource.getRepository(User).count({
      where: {},
    });

    return {
      today: result,
      yesterday: yesterday,
      total: total,
    };
  }
  //
  //
  //
  async totalSearchesToday(): Promise<any> {
    const start = moment(new Date()).subtract(10, 'minutes');
    const endd = moment(new Date());
    const result = await this.dataSource.getRepository(Chat).count({
      where: {
        receiver: IsNull(),
        createdAt: Between(start.toDate(), endd.toDate()),
      },
    });

    const yesterday = await this.dataSource.getRepository(Chat).count({
      where: {
        receiver: IsNull(),
        createdAt: Between(
          moment(new Date()).subtract(48, 'hours').toDate(),
          moment(new Date()).subtract(24, 'hours').toDate(),
        ),
      },
    });

    const today = await this.dataSource.getRepository(Chat).count({
      where: {
        receiver: IsNull(),
        createdAt: Between(
          moment(new Date()).subtract(24, 'hours').toDate(),
          moment(new Date()).toDate(),
        ),
      },
    });

    const total = await this.dataSource.getRepository(Chat).count({
      where: {
        receiver: IsNull(),
      },
    });

    return {
      now: result,
      yesterday: yesterday,
      today: today,
      total: total,
    };
  }
  //
  //
  //
  async totalOnlineUsers(): Promise<any> {
    const start = moment(new Date()).subtract(10, 'minutes');
    const endd = moment(new Date());

    const result = await this.dataSource.getRepository(Session).count({
      where: { end: Between(start.toDate(), endd.toDate()) },
    });

    const yesterday = await this.dataSource.getRepository(Session).count({
      where: {
        end: Between(
          moment(new Date()).subtract(48, 'hours').toDate(),
          moment(new Date()).subtract(24, 'hours').toDate(),
        ),
      },
    });

    const today = await this.dataSource.getRepository(Session).count({
      where: {
        end: Between(
          moment(new Date()).subtract(24, 'hours').toDate(),
          moment(new Date()).toDate(),
        ),
      },
    });

    const total = await this.dataSource.getRepository(User).count({
      where: {
        role: Like('%USER%'),
      },
    });

    return {
      online: result,
      yesterday: yesterday,
      today: today,
      total: total,
    };
  }
}
