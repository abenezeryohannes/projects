import { Test, TestingModule } from '@nestjs/testing';
import { ChatTrainersService } from './chat-trainers.service';

describe('ChatTrainersService', () => {
  let service: ChatTrainersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ChatTrainersService],
    }).compile();

    service = module.get<ChatTrainersService>(ChatTrainersService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
