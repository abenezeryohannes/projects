import { User } from '../../../users/domain/entities/user.entity';
import { Notification } from '../entities/notification.entity';

export class NotificationDto {
  title?: string;
  message?: string;
  arabicTitle?: string;
  arabicMessage?: string;
  seen: boolean;
  userId?: number;
  role?: string;
  fcm?: string;

  constructor(data: any) {
    this.title = data?.title;
    this.message = data?.message;
    //
    this.arabicTitle = data?.arabicTitle;
    this.arabicMessage = data?.arabicMessage;
    //
    this.seen = data?.seen ?? false;
    this.userId = data?.userId ?? null;
    this.role = data?.role ?? 'USER';
    this.fcm = data?.fcm;
  }

  toEntity(creator: User): Notification {
    const notification: Notification = new Notification();
    notification.message = this.message;
    notification.arabicTitle = this.arabicTitle;
    notification.arabicMessage = this.arabicMessage;
    notification.title = this.title;
    notification.seen = this.seen;
    notification.owner = creator;
    return notification;
  }
}
