import { Test, TestingModule } from '@nestjs/testing';
import { ChatTrainersController } from './chat.trainers.controller';

describe('ChatTrainersController', () => {
  let controller: ChatTrainersController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ChatTrainersController],
    }).compile();

    controller = module.get<ChatTrainersController>(ChatTrainersController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
