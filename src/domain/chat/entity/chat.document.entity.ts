import { User } from "../../user/entity/user.entity";

export class ChatDocument {
  id?: number;

  text?: string;

  isActive?: boolean;

  createdAt?: Date;

  updatedAt?: Date;

  sender?: User;

  senderFullName?: string;

  senderAvatar?: string;
}
