import { DataSource } from 'typeorm';
import { User } from '../../../users/domain/entities/user.entity';
import { Chat } from '../entities/chat.entity';

export class CreateChatDto {
  data: string;
  type: string;
  receiverID: number;
  senderID: number;
  constructor(readonly body: any) {
    if (body.data != null || body.data != undefined) this.data = body.data;

    if (body.type != null || body.type != undefined)
      this.type = body.type ?? 'text';

    if (body.receiverID != null || body.receiverID != undefined)
      this.receiverID = body.receiverID;

    if (body.senderID != null || body.senderID != undefined)
      this.senderID = body.senderID;
  }

  async toEntity(dataSource: DataSource): Promise<Chat> {
    const chat = new Chat();
    chat.data = this.data;
    chat.type = this.type;

    if (this.receiverID != null || this.receiverID != undefined)
      chat.receiver = await dataSource
        .getRepository(User)
        .findOne({ where: { id: this.receiverID } });
    if (this.senderID != null || this.senderID != undefined)
      chat.sender = await dataSource
        .getRepository(User)
        .findOne({ where: { id: this.senderID } });
    return chat;
  }
}
