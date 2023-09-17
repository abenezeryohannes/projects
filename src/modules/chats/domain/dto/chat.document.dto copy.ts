import { ChatDocument } from '../entities/chat.document.entity';

export class ChatDocumentDto {
  id?: number;

  text?: string;

  isActive?: boolean;

  constructor(data: any) {
    if (data == null) return;
    if (data.id != null) this.id = data.id;
    if (data.text != null) this.text = data.text;
    if (data.isActive != null) this.isActive = data.isActive;
  }

  static from(entity: ChatDocument): ChatDocumentDto {
    const dto = new ChatDocument();
    dto.id = entity.id;
    dto.text = entity.text;
    dto.isActive = entity.isActive;
    return dto;
  }

  static toEntity(dto: ChatDocumentDto): ChatDocument {
    const entity = new ChatDocument();
    entity.id = dto.id;
    entity.text = dto.text;
    entity.isActive = dto.isActive;
    return entity;
  }
}
