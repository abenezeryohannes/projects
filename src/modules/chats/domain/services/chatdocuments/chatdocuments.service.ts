import { Injectable } from '@nestjs/common';
import { DataSource, Like } from 'typeorm';
import { ChatDocument } from '../../entities/chat.document.entity';
import { ChatDocumentDto } from '../../dto/chat.document.dto copy';

@Injectable()
export class ChatdocumentsService {
  constructor(readonly dataSource: DataSource) {}

  async findAll(query: any): Promise<[ChatDocument[], number]> {
    const limit = Number(query.limit ?? '25');
    const page = Number(query.page ?? '1');
    const search = query.search ?? '';

    const sort = query.sort ?? 'desc';

    let sort_by: any = { id: sort };
    switch (query.sort_by) {
      //   case 'sender':
      //     sort_by = { deliveryTime: sort };
      //     break;
      case 'text':
        sort_by = { badge: sort };
        break;
      case 'isActive':
        sort_by = { badgeColor: sort };
        break;
      default:
        sort_by = { id: sort };
    }

    const [data, count] = await this.dataSource
      .getRepository(ChatDocument)
      .findAndCount({
        where: [{ text: Like('%' + search + '%') }],
        relations: ['sender'],
        order: sort_by,
        take: limit,
        skip: limit * (page - 1),
      });
    return [data, count];
  }

  async deleteAll(ids: number[]): Promise<any> {
    const ops = [];
    ids.forEach((id) => ops.push(this.delete(id)));
    return await Promise.all(ops);
  }

  async delete(id: number): Promise<any> {
    const chatDocument = await this.dataSource
      .getRepository(ChatDocument)
      .findOne({
        where: { id: id },
      });
    return await this.dataSource
      .getRepository(ChatDocument)
      .remove(chatDocument);
  }

  async findOne(id: number): Promise<ChatDocument> | null {
    return this.dataSource
      .getRepository(ChatDocument)
      .findOne({ where: { id: id }, relations: ['sender'] });
  }

  async edit(
    request: any,
    id: number,
    chatDto: ChatDocumentDto,
  ): Promise<ChatDocumentDto> {
    const chatDoc = await this.dataSource
      .getRepository(ChatDocumentDto)
      .findOne({ where: { id: id } });

    if (chatDoc == null)
      throw new Error('Sorry, chat Document not found to edit!');

    if (chatDto.text != null && chatDto.text != undefined) {
      chatDoc.text = chatDto.text;
    }

    if (chatDto.isActive != null && chatDto.isActive != undefined) {
      chatDoc.isActive = chatDto.isActive;
    }

    await this.dataSource.getRepository(ChatDocument).save(chatDoc);

    return chatDoc;
  }

  async add(request: any, chatDto: ChatDocumentDto): Promise<ChatDocument> {
    let chatDoc: ChatDocument = ChatDocumentDto.toEntity(chatDto);

    chatDoc.text = chatDto.text;
    chatDoc.isActive = false;

    chatDoc = await this.dataSource.getRepository(ChatDocument).save(chatDoc);

    return chatDoc;
  }
}
