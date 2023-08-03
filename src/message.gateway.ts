import {
  ConnectedSocket,
  MessageBody,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Socket } from 'socket.io';

@WebSocketGateway({
  cors: {
    credentials: true,
    methods: ['GET', 'POST'],
    origin: '*',
  },
  transports: ['polling', 'websocket'],
})
export class MessageGateway {
  @WebSocketServer()
  server;

  @SubscribeMessage('message')
  handleMessage(
    @MessageBody() message: string,
    @ConnectedSocket() client: Socket,
  ): void {
    console.log(client.handshake.auth);
    console.log(client.handshake.headers.authorization);
    this.server.emit('message', message);
  }
}
