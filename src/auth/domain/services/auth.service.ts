import { Injectable } from '@nestjs/common';
import { User } from 'src/modules/users/domain/entities/user.entity';
import * as Moment from 'moment';
import { DataSource } from 'typeorm';
import { Token } from '../entities/token.entity';
import { UsersService } from '../../../modules/users/domain/services/users.service';
import { UserDto } from '../../../modules/users/domain/dtos/user.dto';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { ROLE } from '../entities/roles';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private dataSource: DataSource,
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  public async login(request: any, requestBody: UserDto): Promise<User> {
    if (!(requestBody.phoneNumber != null && requestBody.UID != null))
      throw 'UID and Phone Number is required to login!';

    let user = await this.dataSource.getRepository(User).findOne({
      where: { phoneNumber: requestBody.phoneNumber },
    });
    if (user == null)
      user = await this.usersService.create(
        new UserDto({
          phoneNumber: requestBody.phoneNumber,
          UID: requestBody.UID,
          role: requestBody.role,
        }),
        request.transaction,
      );
    if (user.UID != requestBody.UID)
      throw 'Incorrect UID, please confirm your phone number first!';

    if (requestBody.role == null) {
      requestBody.role = user.role;
    }

    const userWithToken = await this.generateToken(
      user,
      requestBody,
      request.transaction,
    );

    await this.dataSource.getRepository(User).save(user);
    return userWithToken;
  }

  private async generateToken(user: any, requestBody: any, trans: any) {
    const code = await this.jwtService.signAsync({ user });
    const t = new Token();
    t.user = user;
    t.token = code.length < 254 ? code : code.substring(0, 254);
    t.until = Moment().add(Moment.duration(12, 'months')).toDate();
    t.role = requestBody.role == null ? ROLE.USER : requestBody.role;
    t.fcmToken =
      requestBody.fcmToken.length < 254
        ? requestBody.fcmToken
        : requestBody.fcmToken.substring(0, 254);
    const token = await this.dataSource.getRepository(Token).create(t);
    user.tokens = [token];
    await this.dataSource.getRepository(Token).save(token);
    return user;
  }

  public async logout(token: Token) {
    if (token != null) {
      await this.dataSource.getRepository(Token).delete({
        id: token.id,
      });
    } else throw new Error('No session provided to logout from');
    return WrapperDto.successfull('Logout Successfull');
  }

  public async signUp(request: any, dto: UserDto): Promise<User> {
    if (!(dto.phoneNumber != null && dto.UID != null))
      throw new Error('UID and Phone Number is required to login!');

    const alreadySaved = await this.usersService.findOneByPhoneNumber(
      dto.phoneNumber,
    );
    if (alreadySaved != null) {
      const x = await this.login(request, dto);
      return x;
    }

    // create the user
    const newUser = await this.usersService.create(dto, request.transaction);
    // generate token
    const newUserWIthToken = await this.generateToken(
      newUser,
      request.body,
      request.transaction,
    );
    return newUserWIthToken;
  }

  async updateFCM(request: any): Promise<User> {
    if (request.body.fcm == null || request.body.fcm == undefined)
      throw 'No FCM provided!';
    request.token.fcmToken = request.body.fcm;
    request.token = await request.token.save();
    request.user.Token = request.token;
    return request.user;
  }
}
