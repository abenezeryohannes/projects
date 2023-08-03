import { Module } from '@nestjs/common';
import { ChatsService } from './domain/services/chats.service';
import { ChatsGateway } from './gateways/chats.gateway';
import { ChatsController } from './chats/chats.controller';

@Module({
  providers: [ChatsGateway, ChatsService],
  controllers: [ChatsController],
})
export class ChatsModule {}
