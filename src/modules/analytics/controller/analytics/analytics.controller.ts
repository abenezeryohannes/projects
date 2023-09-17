import { Controller, Get, Request } from '@nestjs/common';
import { AnalyticsService } from '../../service/analytics/analytics.service';
import { ROLE } from '../../../../auth/domain/entities/roles';
import { Roles } from '../../../../auth/domain/guards/roles.decorator';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';

@Controller('analytics')
export class AnalyticsController {
  constructor(readonly service: AnalyticsService) {}

  //@Roles(ROLE.ADMIN)
  @Get('total_users')
  async findTotalUsers(@Request() request: any) {
    try {
      const response = await this.service.totalUsers(request, request.query);
      return WrapperDto.successfull(response);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //@Roles(ROLE.ADMIN)
  @Get('total_stores')
  async findTotalStores(@Request() request: any) {
    try {
      const response = await this.service.totalStores(request, request.query);
      return WrapperDto.successfull(response);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //@Roles(ROLE.ADMIN)
  @Get('new_business_count')
  async countNewBusinesses(@Request() request: any) {
    try {
      const response = await this.service.totalNewBusinesses(
        request,
        request.query,
      );
      return WrapperDto.successfull(response);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //@Roles(ROLE.ADMIN)
  @Get('total_searches_today')
  async findSearchesToday() {
    try {
      const response = await this.service.totalSearchesToday();
      return WrapperDto.successfull(response);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  //   @Roles(ROLE.ADMIN)
  @Get('total_online_users')
  async findOnlineUsers() {
    try {
      const response = await this.service.totalOnlineUsers();
      return WrapperDto.successfull(response);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Get('new_businesses')
  async findNewBusinesses(@Request() request: any) {
    try {
      const [result, count] = await this.service.findNewBusinesses(
        request,
        request.query,
      );
      return WrapperDto.paginate(result, count, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Get('clicked_businesses')
  async findClickedBusinesses(@Request() request: any) {
    try {
      const [result, count] = await this.service.findClickedBusiness(
        request,
        request.query,
      );
      return WrapperDto.paginate(result, count, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Get('most_searched_tags')
  async mostSearchedTags(@Request() request: any) {
    try {
      const [result, count] = await this.service.findMostSearchedTags(
        request,
        request.query,
      );
      return WrapperDto.paginate(result, count, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
