import { Body, Controller, Get, Post, Request } from '@nestjs/common';
import { Roles } from '../../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../../auth/domain/entities/roles';
import { TagsService } from '../../domain/services/tags/tags.service';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';

@Controller('tags')
export class TagsController {
  constructor(readonly service: TagsService) {}

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get('findAll')
  async findAll(@Request() request) {
    try {
      const result = await this.service.findAll();
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //add
  @Roles(ROLE.ADMIN)
  @Post('add')
  async add(@Request() request, @Body() body) {
    try {
      const result = await this.service.add(request, body);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  // @Roles(ROLE.ADMIN)
  @Post('addAll')
  async addAll(@Request() request, @Body() body) {
    try {
      const result = await this.service.addAll(request, body);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
