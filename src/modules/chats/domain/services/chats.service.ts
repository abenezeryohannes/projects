import { Injectable } from '@nestjs/common';
import { DataSource, LessThan } from 'typeorm';
import { Socket } from 'socket.io';
import { WsException } from '@nestjs/websockets';
import { Chat } from '../entities/chat.entity';
import { UpdateChatDto } from '../dto/update-chat.dto';
import { Token } from '../../../../auth/domain/entities/token.entity';
import { CreateChatDto } from '../dto/create-chat.dto';
import { User } from '../../../users/domain/entities/user.entity';

@Injectable()
export class ChatsService {
  constructor(readonly dataSource: DataSource) {}

  async getUserFromSocket(socket: Socket) {
    const auth_token =
      socket.handshake.auth.authorization ??
      socket.handshake.headers.authorization;
    if (auth_token == null || auth_token.length == 0) {
      throw new WsException('Invalid credentials.');
    }

    const jwt = auth_token.replace('Bearer ', '');
    const token = await this.dataSource.getRepository(Token).findOne({
      where: { token: jwt },
      relations: {
        user: true,
      },
    });

    if (token == null) {
      throw new WsException('Invalid credentials.');
    } else return token.user;
  }

  async create(request: any, createChatDto: CreateChatDto): Promise<Chat> {
    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });
    const chat = new Chat();
    chat.data = createChatDto.data;
    chat.type = createChatDto.type;
    chat.sender = user;
    return await this.dataSource.getRepository(Chat).save(chat);
  }

  async findAll(request: any): Promise<any> {
    const limit = request.query.limit ?? 25;
    const page = request.query.page ?? 1;
    const id = request.query.id ?? -1;

    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });

    const sqlQuery = [{ sender: user }, { receiver: user }];

    const [chats, count] = await this.dataSource
      .getRepository(Chat)
      .findAndCount({
        where:
          id > 0
            ? [
                { sender: user, id: LessThan(id) },
                { receiver: user, id: LessThan(id) },
              ]
            : sqlQuery,
        take: limit,
        relations: ['sender', 'receiver'],
        order: {
          id: 'DESC',
        },
        skip: id > 0 ? 0 : limit * (page - 1),
      });

    return {
      data: chats,
      count: count,
    };
  }

  findOne(id: number) {
    return `This action returns a #${id} chat`;
  }
}
