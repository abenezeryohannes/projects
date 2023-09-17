import { Test, TestingModule } from '@nestjs/testing';
import { ChatdocumentsController } from './chatdocuments.controller';

describe('ChatdocumentsController', () => {
  let controller: ChatdocumentsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ChatdocumentsController],
    }).compile();

    controller = module.get<ChatdocumentsController>(ChatdocumentsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
