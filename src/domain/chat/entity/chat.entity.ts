import { User } from "../../user/entity/user.entity";

export class Chat {
  id?: number;

  data?: string;

  type?: string;

  context?: string;

  isActive?: boolean;

  createdAt?: Date;

  updatedAt?: Date;

  receiver?: User;

  sender?: User;
}
