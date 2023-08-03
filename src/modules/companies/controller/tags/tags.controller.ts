import { Controller, Get, Request } from '@nestjs/common';
import { Roles } from '../../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../../auth/domain/entities/roles';
import { TagsService } from '../../domain/services/tags/tags.service';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';

@Controller('tags')
export class TagsController {
  constructor(readonly tagService: TagsService) {}
  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get('findAll')
  async findAll(@Request() request) {
    try {
      const result = await this.tagService.findAll();
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
