import { Module } from '@nestjs/common';
import { CompaniesController } from './controller/companies/companies.controller';
import { CompaniesService } from './domain/services/companies/companies.service';
import { TagsController } from './controller/tags/tags.controller';
import { TagsService } from './domain/services/tags/tags.service';
import { CompanyIdentifierController } from './controller/companies/company-identifier/company-identifier.controller';
import { CompanyIdentifierService } from './domain/services/companies/company-identifier/company-identifier.service';
import { TagIdentifierService } from './domain/services/tags/tag-identifier/tag-identifier.service';
import { TagIdentifierController } from './controller/tags/tag-identifier/tag-identifier.controller';

@Module({
  controllers: [
    CompaniesController,
    TagsController,
    TagIdentifierController,
    CompanyIdentifierController,
  ],
  providers: [
    CompaniesService,
    TagsService,
    CompanyIdentifierService,
    TagIdentifierService,
  ],
})
export class CompaniesModule {}
