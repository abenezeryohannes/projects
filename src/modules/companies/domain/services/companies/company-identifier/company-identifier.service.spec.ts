import { Test, TestingModule } from '@nestjs/testing';
import { CompanyIdentifierService } from './company-identifier.service';

describe('CompanyIdentifierService', () => {
  let service: CompanyIdentifierService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CompanyIdentifierService],
    }).compile();

    service = module.get<CompanyIdentifierService>(CompanyIdentifierService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
