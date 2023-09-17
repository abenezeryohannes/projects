import { User } from "./user.entity";

export class Notification {
  id?: number;

  title?: string;

  message?: string;

  arabicTitle?: string;

  arabicMessage?: string;

  seen?: boolean;

  createdAt?: Date;

  updatedAt?: Date;

  receiver?: User;

  owner?: User;
}
