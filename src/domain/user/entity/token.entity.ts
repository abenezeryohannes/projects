import { User } from "./user.entity";

export class Token {
  id?: number;

  token?: string;

  fcmToken?: string;

  role?: string;

  until?: Date;

  user?: User;

  constructor(data: any) {
    this.id = Number(data?.id);
    this.token = String(data?.token);
    this.fcmToken = String(data?.fcmToken);
    this.role = String(data?.role);
  }
}
