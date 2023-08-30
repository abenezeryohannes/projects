export class Setting {
  id: number;
  userId: number;
  bookingNotification: boolean;
  faceId: boolean;
  constructor(data: any) {
    this.id = data?.id;
    this.userId = data?.userId;
    this.bookingNotification = data?.bookingNotification;
    this.faceId = data?.faceId;
  }
}
