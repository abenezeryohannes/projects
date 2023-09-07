import { Module } from '@nestjs/common';
import { ChatsService } from './domain/services/chats.service';
import { ChatsGateway } from './gateways/chats.gateway';
import { ChatsController } from './controllers/chats/chats.controller';
import { ChatTrainersController } from './controllers/chat-trainers/chat.trainers.controller';
import { ChatTrainersService } from './domain/services/chat-trainers/chat-trainers.service';
import { SuggestionController } from './controllers/suggestion/suggestion.controller';
import { SuggestionService } from './domain/services/suggestion/suggestion.service';

@Module({
  providers: [
    ChatsGateway,
    ChatsService,
    ChatTrainersService,
    SuggestionService,
  ],
  controllers: [ChatsController, ChatTrainersController, SuggestionController],
})
export class ChatsModule {}
