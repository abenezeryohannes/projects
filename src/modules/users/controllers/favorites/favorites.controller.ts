import { Controller, Get, Param, Post, Request } from '@nestjs/common';
import { Roles } from '../../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../../auth/domain/entities/roles';
import { FavoritesService } from '../../domain/services/favorites/favorites.service';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';

@Controller('favorites')
export class FavoritesController {
  constructor(readonly favService: FavoritesService) {}

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get()
  async findAllUsers(@Request() request) {
    try {
      const result = await this.favService.findAll(request);
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Post('set/:company_id')
  async set(@Request() request, @Param('company_id') company_id: number) {
    try {
      const result = await this.favService.set(request, company_id);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Post('un-set/:id')
  async unSet(@Request() request, @Param('id') id: number) {
    try {
      const result = await this.favService.unSet(request, id);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
