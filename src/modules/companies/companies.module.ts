import { Module } from '@nestjs/common';
import { CompaniesController } from './controller/companies/companies.controller';
import { CompaniesService } from './domain/services/companies/companies.service';
import { TagsController } from './controller/tags/tags.controller';
import { TagsService } from './domain/services/tags/tags.service';

@Module({
  controllers: [CompaniesController, TagsController],
  providers: [CompaniesService, TagsService],
})
export class CompaniesModule {}
