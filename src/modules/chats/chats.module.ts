import { Module } from '@nestjs/common';
import { ChatsService } from './domain/services/chats.service';
import { ChatsGateway } from './gateways/chats.gateway';
import { ChatsController } from './controllers/chats/chats.controller';
import { ChatTrainersController } from './controllers/chat-trainers/chat.trainers.controller';
import { ChatTrainersService } from './domain/services/chat-trainers/chat-trainers.service';

@Module({
  providers: [ChatsGateway, ChatsService, ChatTrainersService],
  controllers: [ChatsController, ChatTrainersController],
})
export class ChatsModule {}
