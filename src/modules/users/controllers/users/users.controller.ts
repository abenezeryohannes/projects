import {
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Request,
  UseInterceptors,
} from '@nestjs/common';
import { Roles } from '../../../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../../../auth/domain/entities/roles';
import { UsersService } from '../../domain/services/users.service';
import { UserEditDto } from '../../domain/dtos/user.edit.dto';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';
import { FastifyFileInterceptor } from '../../../../fastify.file.interceptor';
import { diskStorage } from 'fastify-multer';
import { join } from 'path';
import {
  editFileName,
  imageFileFilter,
} from '../../../../core/dto/file.upload.dto';
import { validateOrReject } from 'class-validator';

@Controller('users')
export class UsersController {
  constructor(private userService: UsersService) {}

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get()
  async get(@Request() request) {
    try {
      const result = await this.userService.findOne(request.user.id);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Post('edit')
  @UseInterceptors(
    FastifyFileInterceptor('avatar', {
      storage: diskStorage({
        destination: join(process.cwd(), 'assets', 'public'),
        filename: editFileName,
      }),
      limits: {
        fieldSize: 10485760,
      },
      fileFilter: imageFileFilter,
    }),
  )
  async edit(@Request() request) {
    try {
      const userEditDto = new UserEditDto(request.body);
      await validateOrReject(userEditDto);
      const result = await this.userService.edit(request, userEditDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Get(':id')
  async find(@Request() request, @Param('id') id: number) {
    try {
      const result = await this.userService.findOne(id);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('findAll')
  async findAllUsers(@Request() request) {
    try {
      const result = await this.userService.findAll(request);
      return WrapperDto.paginateHalf(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @Delete('delete')
  async delete(@Request() request) {
    try {
      const result = await this.userService.delete(request);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
