import { Module } from '@nestjs/common';
import { NotificationsController } from './controller/notifications/notifications.controller';
import { NotificationsService } from './domain/services/notifications/notifications.service';
import { FirebaseModule } from '../../firebase.module';

// import {
//   FirebaseModule,
//   FirebaseService,
// } from '@speakbox/nestjs-firebase-admin';

@Module({
  imports: [
    /*FirebaseModule*/
  ],
  controllers: [NotificationsController],
  providers: [NotificationsService],
})
export class NotificationsModule {}
