import { Module } from '@nestjs/common';
import { AnalyticsService } from './service/analytics/analytics.service';
import { AnalyticsController } from './controller/analytics/analytics.controller';

@Module({
  controllers: [AnalyticsController],
  providers: [AnalyticsService],
})
export class AnalyticsModule {}
