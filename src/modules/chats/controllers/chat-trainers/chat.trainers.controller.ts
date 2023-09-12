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
      const [result, count] = await this.service.findAll(request);
      return WrapperDto.paginate(result, count, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('commands')
  async findCommands(@Request() request) {
    try {
      const result = await this.service.findCommandAll(request);
      return WrapperDto.paginateHalf(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('intents')
  async findIntents(@Request() request) {
    try {
      const [result, count] = await this.service.findIntentAll(request);
      return WrapperDto.paginate(result, Number(count), request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('intents/delete')
  async deleteIntents(@Request() request) {
    try {
      const result = await this.service.deleteIntent(request);
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

  //utterances

  @Roles(ROLE.ADMIN)
  @Post('utterances/:id/edit')
  async editUtterance(@Request() request, @Param('id') id: number) {
    try {
      const result = await this.service.editUtterance(id, request.body);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('utterances/delete')
  async deleteUtterance(@Request() request) {
    try {
      const result = await this.service.deleteUtterance(request.body.id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('utterances/delete_all')
  async deleteAll(@Request() request) {
    try {
      const result = await this.service.deleteAllUtterances(
        JSON.parse(request.body.ids),
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
