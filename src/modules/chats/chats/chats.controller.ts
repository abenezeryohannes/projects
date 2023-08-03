import { Controller, Get, Request } from '@nestjs/common';
import { Roles } from '../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../auth/domain/entities/roles';
import { ChatsService } from '../domain/services/chats.service';
import { WrapperDto } from '../../../core/dto/wrapper.dto';

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
}
