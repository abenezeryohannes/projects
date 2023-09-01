import { Test, TestingModule } from '@nestjs/testing';
import { TagIdentifierService } from './tag-identifier.service';

describe('TagIdentifierService', () => {
  let service: TagIdentifierService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [TagIdentifierService],
    }).compile();

    service = module.get<TagIdentifierService>(TagIdentifierService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
