import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Request,
} from '@nestjs/common';
import { TagIdentifierService } from '../../../domain/services/tags/tag-identifier/tag-identifier.service';
import { Roles } from '../../../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../../../auth/domain/entities/roles';
import { WrapperDto } from '../../../../../core/dto/wrapper.dto';

@Controller('tag-identifiers')
export class TagIdentifierController {
  constructor(readonly service: TagIdentifierService) {}

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get(':tagId')
  async findAll(@Request() request, @Param('tagId') tagId: number) {
    try {
      const result = await this.service.findAll(request, tagId);
      return WrapperDto.paginateHalf(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
  //add
  @Roles(ROLE.ADMIN)
  @Post('add')
  async add(@Request() request, @Body() body) {
    try {
      const result = await this.service.add(body);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  // @Roles(ROLE.ADMIN)
  @Post('addAll')
  async addAll(@Request() request, @Body() body) {
    try {
      const result = await this.service.addAll(body);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Delete('delete/:id')
  async delete(@Request() request, @Param('id') id: number) {
    try {
      const result = await this.service.delete(id);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('deleteAll')
  async deleteAll(@Request() request, @Body() body) {
    try {
      const result = await this.service.deleteAll(body);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('deleteByTag/:tagId')
  async deleteByTag(@Request() request, @Param('tagId') tagId: number) {
    try {
      const result = await this.service.deleteAllByTag(tagId, null);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //
}
