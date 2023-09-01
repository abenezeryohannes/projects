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
import { ChatTrainersService } from '../../domain/services/chat-trainers/chat-trainers.service';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';

@Controller('chat-trainers')
export class ChatTrainersController {
  constructor(readonly service: ChatTrainersService) {}
  //findAll
  @Roles(ROLE.ADMIN)
  @Get()
  async findAll(@Request() request) {
    try {
      const result = await this.service.findAll(request);
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
      const result = await this.service.add(request, body);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('addAll')
  async addAll(@Request() request, @Body() body) {
    try {
      const result = await this.service.addAll(request, body);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //delete
  @Roles(ROLE.ADMIN)
  @Delete('delete/:id')
  async delete(@Request() request, @Param() id: number) {
    try {
      const result = await this.service.delete(request, id);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //clear
  @Roles(ROLE.ADMIN)
  @Post('clearAll')
  async clear(@Request() request) {
    try {
      const result = await this.service.clearAll();
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //train
  @Roles(ROLE.ADMIN)
  @Post('train')
  async train(@Request() request) {
    try {
      const result = await this.service.train();
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
