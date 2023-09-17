import { Controller, Get, Param, Post, Request } from '@nestjs/common';
import { ChatdocumentsService } from '../../domain/services/chatdocuments/chatdocuments.service';
import { Roles } from '../../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../../auth/domain/entities/roles';
import { ChatDocumentDto } from '../../domain/dto/chat.document.dto copy';
import { validateOrReject } from 'class-validator';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';

@Controller('chatdocuments')
export class ChatdocumentsController {
  constructor(readonly service: ChatdocumentsService) {}

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
  @Post('add')
  async add(@Request() request) {
    try {
      const chatDocumentDto = new ChatDocumentDto(request.body);
      await validateOrReject(chatDocumentDto);
      const result = await this.service.add(request, chatDocumentDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Post(':id/edit')
  async edit(@Request() request, @Param('id') id: number) {
    try {
      const chatDocumentDto = new ChatDocumentDto(request.body);
      await validateOrReject(chatDocumentDto);
      const result = await this.service.edit(request, id, chatDocumentDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('delete')
  async delete(@Request() request) {
    try {
      const result = await this.service.delete(request.body.id);
      return WrapperDto.successfull(result);
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
}
