import { Test, TestingModule } from '@nestjs/testing';
import { ChatdocumentsService } from './chatdocuments.service';

describe('ChatdocumentsService', () => {
  let service: ChatdocumentsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ChatdocumentsService],
    }).compile();

    service = module.get<ChatdocumentsService>(ChatdocumentsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
