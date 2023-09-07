import { Injectable } from '@nestjs/common';
import { DataSource, Like } from 'typeorm';
import { Suggestion } from '../../entities/suggestion.entity';
import { SuggestionDTO } from '../../dto/suggestion.dto';

@Injectable()
export class SuggestionService {
  constructor(readonly dataSource: DataSource) {}

  async findAll(query: any): Promise<[Suggestion[], number]> {
    const limit = Number(query.limit ?? '25');
    const page = Number(query.page ?? '1');
    const search = query.search ?? '';

    const sort = query.sort ?? 'desc';

    let sort_by: any = { id: sort };
    switch (query.sort_by) {
      case 'title':
        sort_by = { type: sort };
        break;
      case 'text':
        sort_by = { name: sort };
        break;
      default:
        sort_by = { id: sort };
    }

    const [data, count] = await this.dataSource
      .getRepository(Suggestion)
      .findAndCount({
        where: [
          { title: Like('%' + search + '%') },
          { text: Like('%' + search + '%') },
        ],
        order: sort_by,
        take: limit,
        skip: limit * (page - 1),
      });
    return [data, count];
  }

  async add(request: any, body: SuggestionDTO): Promise<Suggestion> {
    let suggestion = new Suggestion();
    suggestion.title = body.title;
    suggestion.text = body.text;
    suggestion.isActive = body.isActive;

    suggestion = await this.dataSource
      .getRepository(Suggestion)
      .save(suggestion);
    //
    return suggestion;
  }

  async deleteAll(request: any, ids: number[]): Promise<Suggestion[]> {
    const op = [];
    for (let i = 0; i < ids.length; i++) {
      op.push(this.delete(ids[i]));
    }
    return Promise.all(op);
  }

  async edit(id: number, suggestionDto: SuggestionDTO): Promise<Suggestion> {
    let suggestion = await this.dataSource.getRepository(Suggestion).findOne({
      where: { id: id },
    });

    if (suggestionDto.title != null && suggestionDto.title != undefined) {
      suggestion.title = suggestionDto.title;
    }

    if (suggestionDto.text != null && suggestionDto.text != undefined) {
      suggestion.text = suggestionDto.text;
    }

    if (suggestionDto.isActive != null && suggestionDto.isActive != undefined) {
      suggestion.isActive = suggestionDto.isActive;
    }

    suggestion = await this.dataSource
      .getRepository(Suggestion)
      .save(suggestion);

    return suggestion;
  }

  async delete(id: number): Promise<any> {
    return await this.dataSource.getRepository(Suggestion).delete({
      id: id,
    });
  }
}
