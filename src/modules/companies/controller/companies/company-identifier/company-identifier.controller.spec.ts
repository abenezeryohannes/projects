import { Test, TestingModule } from '@nestjs/testing';
import { CompanyIdentifierController } from './company-identifier.controller';

describe('CompanyIdentifierController', () => {
  let controller: CompanyIdentifierController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CompanyIdentifierController],
    }).compile();

    controller = module.get<CompanyIdentifierController>(
      CompanyIdentifierController,
    );
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
