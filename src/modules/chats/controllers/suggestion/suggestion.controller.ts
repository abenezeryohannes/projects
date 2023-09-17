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
import { WrapperDto } from '../../../../core/dto/wrapper.dto';
import { SuggestionService } from '../../domain/services/suggestion/suggestion.service';
import { SuggestionDTO } from '../../domain/dto/suggestion.dto';
import { validateOrReject } from 'class-validator';

@Controller('suggestions')
export class SuggestionController {
  constructor(readonly service: SuggestionService) {}

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get()
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

  @Roles(ROLE.ADMIN)
  @Get('add')
  async add(@Request() request) {
    try {
      const suggestionDTO = new SuggestionDTO(request.body);
      await validateOrReject(suggestionDTO);
      const result = await this.service.add(request, suggestionDTO);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post(':id/edit')
  async edit(@Request() request, @Param('id') id: number) {
    try {
      const suggestionDTO = new SuggestionDTO(request.body);
      await validateOrReject(suggestionDTO);
      const result = await this.service.edit(id, suggestionDTO);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Post('delete')
  async delete(@Request() request, @Body() body) {
    try {
      const result = await this.service.delete(body.id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Post('delete_all')
  async deleteAll(@Request() request) {
    try {
      const result = await this.service.deleteAll(
        request,
        JSON.parse(request.body.ids),
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
