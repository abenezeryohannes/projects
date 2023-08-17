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
import { ChatsService } from '../../domain/services/chats.service';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';

@Controller('chats')
export class ChatsController {
  constructor(readonly service: ChatsService) {}

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get()
  async findAll(@Request() request) {
    try {
      const result = await this.service.findAll(request);
      return WrapperDto.paginate(result.data, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Delete('delete')
  async delete(@Request() request, @Body() body) {
    try {
      const result = await this.service.delete(request, body.id);
      return WrapperDto.successfull(result.data);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Delete('clearAll')
  async clearAll(@Request() request) {
    try {
      const result = await this.service.clearAll(request);
      return WrapperDto.successfull(result.data);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Delete('clear')
  async clear(@Request() request) {
    try {
      const result = await this.service.clear(request);
      return WrapperDto.successfull(result.data);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get('test/:utterance')
  async test(@Request() request, @Param('utterance') utterance: string) {
    try {
      const result = await this.service.getTrainedAiResponse(
        utterance,
        request.user,
      );
      return WrapperDto.paginate(result.data, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
