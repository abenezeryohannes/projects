import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { User } from '../entities/user.entity';
import { UserDto } from '../dtos/user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { join } from 'path';
import { Token } from '../../../../auth/domain/entities/token.entity';
import { Chat } from '../../../chats/domain/entities/chat.entity';
import { Favorite } from '../entities/favorite.entity';
import { Company } from '../../../companies/domain/entities/company.entity';
import { UserEditDto } from '../dtos/user.edit.dto';

@Injectable()
export class UsersService {
  constructor(private dataSource: DataSource) {}

  findAll(request: any): Promise<User[]> {
    return this.dataSource.getRepository(User).find();
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
    const userSaved = await this.dataSource.getRepository(User).save(result);
    return await this.dataSource.getRepository(User).findOne({
      where: { id: userSaved.id },
      relations: ['tokens'],
    });
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
}
