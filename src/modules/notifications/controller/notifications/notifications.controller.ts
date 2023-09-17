import { Controller, Get, Post, Request } from '@nestjs/common';
import { NotificationsService } from '../../domain/services/notifications/notifications.service';
import { Roles } from '../../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../../auth/domain/entities/roles';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';

@Controller('notifications')
export class NotificationsController {
  constructor(private readonly service: NotificationsService) {}

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get()
  async find(@Request() request) {
    try {
      const [result, count] = await this.service.find(request, request.query);
      return WrapperDto.paginate(result, count, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('all')
  async findAll(@Request() request) {
    try {
      const [result, count] = await this.service.findAll(
        request,
        request.query,
      );
      return WrapperDto.paginate(result, count, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get('find_all_un_seen')
  async findAllUnSeen(@Request() request) {
    try {
      const [result, count] = await this.service.findAllUnseen(
        request,
        request.query,
      );
      return WrapperDto.paginate(result, count, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Post('seen')
  async seen(@Request() request) {
    try {
      const result = await this.service.seen(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get('un_seen_count')
  async unseenCount(@Request() request) {
    try {
      const result = await this.service.unseenCount(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Post('clear')
  async clear(@Request() request) {
    try {
      const result = await this.service.clear(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('send')
  async send(@Request() request) {
    try {
      const result = await this.service.SendMessage(
        request,
        request.body,
        true,
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
