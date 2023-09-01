import { Test, TestingModule } from '@nestjs/testing';
import { TagIdentifierController } from './tag-identifier.controller';

describe('TagIdentifierController', () => {
  let controller: TagIdentifierController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [TagIdentifierController],
    }).compile();

    controller = module.get<TagIdentifierController>(TagIdentifierController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
