import { Injectable } from '@nestjs/common';
import { DataSource, In, Like, Repository } from 'typeorm';
import { User } from '../entities/user.entity';
import { UserDto } from '../dtos/user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { join } from 'path';
import { Token } from '../../../../auth/domain/entities/token.entity';
import { Chat } from '../../../chats/domain/entities/chat.entity';
import { Favorite } from '../entities/favorite.entity';
import { Company } from '../../../companies/domain/entities/company.entity';
import { UserEditDto } from '../dtos/user.edit.dto';
import { Session } from '../entities/session.entity';
import * as moment from 'moment';
@Injectable()
export class UsersService {
  constructor(private dataSource: DataSource) {}

  async findAll(request: any, query: any): Promise<[User[], number]> {
    const limit = Number(query.limit ?? '25');
    const page = Number(query.page ?? '1');
    const role = query.role;
    const search = query.search ?? '';

    const sort = query.sort ?? 'desc';

    let sort_by: any = { id: sort };
    switch (query.sort_by) {
      case 'fullName':
        sort_by = { like: sort };
        break;
      case 'phoneNumber':
        sort_by = { name: sort };
        break;
      default:
        sort_by = { id: sort };
    }
    const whereOps = [
      {
        fullName: Like('%' + search + '%'),
        role: Like('%%'),
        isActive: request.user.role != 'ADMIN' ? true : In([true, false]),
      },
      {
        phoneNumber: Like('%' + search + '%'),
        role: Like('%%'),
        isActive: request.user.role != 'ADMIN' ? true : In([true, false]),
      },
    ];
    if (role != null)
      whereOps.forEach((e) => {
        if (role != null) e.role = Like('%' + role + '%');
      });

    const [data, count] = await this.dataSource
      .getRepository(User)
      .findAndCount({
        where: whereOps,
        order: sort_by,
        take: limit,
        skip: limit * (page - 1),
      });
    return [data, count];
  }

  findOne(id: number): Promise<User | null> {
    if (id == null || id < 1) throw new Error('No id provided');
    return this.dataSource.getRepository(User).findOneBy({ id });
  }

  async remove(id: number): Promise<void> {
    if (id == null || id < 1) throw new Error('No id provided');
    await this.dataSource.getRepository(User).delete(id);
  }

  async create(user: UserDto, transaction: any): Promise<User> {
    const userExist = await this.dataSource.getRepository(User).findOne({
      where: { phoneNumber: user.phoneNumber, UID: user.UID },
    });
    if (userExist != null) return userExist;

    if (user.fullName == null)
      user.fullName = ('user' + (Math.random() * 1000000000 + 1)).replaceAll(
        '.',
        '',
      );
    const result = await this.dataSource
      .getRepository(User)
      .create({ ...user });
    // if (
    //   user.Location != null &&
    //   isNumber(user.Location.latitude) &&
    //   isNumber(user.Location.longitude)
    // ) {
    //   const location = await this.dataSource
    //     .getRepository(User)
    //     .create<Location>(
    //       {
    //         latitude: user.Location.latitude,
    //         longitude: user.Location.longitude,
    //         address: user.Location.address,
    //       },
    //       { transaction: transaction },
    //     );
    //   result.locationId = location.id;
    // }
    await this.dataSource.getRepository(User).save(result);
    return result;
  }

  async edit(request: any, dto: UserEditDto) {
    const currentUser = await this.findOne(request.user.id);
    if (dto.fullName != null) currentUser.fullName = dto.fullName;
    if (dto.language != null) currentUser.language = dto.language;
    if (dto.theme != null) currentUser.theme = dto.theme;
    if (request.file != null)
      currentUser.avatar = join('public', request.file.filename);
    await this.dataSource.manager.save(currentUser);
    return currentUser;
  }

  async delete(request: any) {
    const user = await this.dataSource
      .getRepository(User)
      .findOneBy({ id: request.user.id });
    //
    const companies = await this.dataSource.getRepository(Company).find({
      where: { user: user },
    });
    //delete token
    await this.dataSource
      .getRepository(Token)
      .delete({ token: request.token.token });
    //delete chat
    await this.dataSource.getRepository(Chat).delete({ sender: user });
    await this.dataSource.getRepository(Chat).delete({ receiver: user });
    //delete fav
    await this.dataSource
      .getRepository(Favorite)
      .delete({ company: In(companies) });
    //delete company
    await this.dataSource.getRepository(Company).delete({ user: user });
    //delete company fav
    await this.dataSource.getRepository(Favorite).delete({ user: user });
    //delete user
    await this.dataSource.getRepository(User).delete({ id: user.id });
    return true;
  }

  async findOneByPhoneNumber(phoneNumber: string): Promise<User> | null {
    return this.dataSource.getRepository(User).findOne({
      where: {
        phoneNumber: phoneNumber,
      },
    });
  }

  async online(request: any): Promise<Session | null> {
    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });

    const latestSession = await this.dataSource.getRepository(Session).findOne({
      where: { user: user },
      order: { id: 'DESC' },
    });
    if (
      latestSession != null &&
      moment(latestSession.end).diff(moment(Date()), 'minutes') <= 10
    ) {
      latestSession.end = new Date();
      return await this.dataSource.getRepository(Session).save(latestSession);
    } else {
      const session = new Session();
      session.user = user;
      return await this.dataSource.getRepository(Session).save(session);
    }
  }
}
