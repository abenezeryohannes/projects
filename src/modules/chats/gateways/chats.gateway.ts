import {
  WebSocketGateway,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Logger } from '@nestjs/common';
import { ChatsService } from '../domain/services/chats.service';
import { CreateChatDto } from '../domain/dto/create-chat.dto';

@WebSocketGateway(5000, {
  cors: {
    credentials: true,
    methods: ['GET', 'POST'],
    origin: '*',
  },
  transports: ['polling', 'websocket'],
})
export class ChatsGateway implements OnGatewayConnection, OnGatewayDisconnect {
  private logger = new Logger('ChatsGateway');

  @WebSocketServer()
  server: Server;

  constructor(private readonly chatsService: ChatsService) {}

  handleDisconnect(client: any) {
    this.logger.log('Client disconnected');
  }

  handleConnection(client: any, ...args: any[]) {
    this.logger.log('New client connected');
  }

  @SubscribeMessage('sendMessage')
  async create(
    @MessageBody() createChatDto: CreateChatDto,
    @ConnectedSocket() client: Socket,
  ) {
    const user = await this.chatsService.getUserFromSocket(client);
    createChatDto.senderID = user.id;

    const chat = await this.chatsService.create(
      {
        user: user,
      },
      createChatDto,
    );
    this.server.emit('GxcR9hm4SPau5sYQtrJAAkt8vnp2', JSON.stringify(chat));

    //client.broadcast.emit('receiveMessage', JSON.stringify(chat));
  }

  @SubscribeMessage('findAllChats')
  async findAll(@ConnectedSocket() client: Socket) {
    const user = await this.chatsService.getUserFromSocket(client);
    const chats = await this.chatsService.findAll({
      user: user,
      query: {
        page: client.handshake.query.page,
        limit: client.handshake.query.limit,
        id: client.handshake.query.id,
      },
    });
    return client.broadcast.emit('findAllChats', JSON.stringify(chats));
  }

  @SubscribeMessage('typing')
  async typing(
    @MessageBody('isTyping') isTyping: boolean,
    @ConnectedSocket() client: Socket,
  ) {
    const user = await this.chatsService.getUserFromSocket(client);
    client.broadcast.emit('typing', { user, isTyping });
  }
}
