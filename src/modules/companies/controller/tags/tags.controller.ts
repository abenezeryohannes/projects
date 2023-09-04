import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Request,
} from '@nestjs/common';
import { Roles } from '../../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../../auth/domain/entities/roles';
import { TagsService } from '../../domain/services/tags/tags.service';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';
import { TagDto } from '../../domain/dtos/tag.dto';
import { validateOrReject } from 'class-validator';

@Controller('tags')
export class TagsController {
  constructor(readonly service: TagsService) {}

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get()
  async findAll(@Request() request) {
    try {
      const [data, count] = await this.service.findAll(request.query);
      return WrapperDto.paginate(data, count, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get('types')
  async findAllTypes(@Request() request) {
    try {
      const resp = await this.service.findAllTypes(request.query);
      return WrapperDto.paginateHalf(resp, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post(':id/edit')
  async edit(@Request() request, @Param('id') id: number) {
    try {
      const tagDto = new TagDto(request.body);
      await validateOrReject(tagDto);
      const result = await this.service.edit(id, tagDto);
      return WrapperDto.successfull(result);
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
  @Post('delete')
  async delete(@Request() request) {
    try {
      const result = await this.service.delete(request.body.id);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('delete_all')
  async deleteAll(@Request() request) {
    try {
      const result = await this.service.deleteAll(JSON.parse(request.body.ids));
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
  // // @Roles(ROLE.ADMIN)
  @Delete('clearAll')
  async clearAll(@Request() request) {
    try {
      const result = await this.service.clearAll();
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //

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

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get(':id')
  async find(@Request() request, @Param('id') id: number) {
    try {
      const result = await this.service.find(id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
