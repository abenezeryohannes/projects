import { Injectable } from '@nestjs/common';
import { DataSource, ILike, MoreThan } from 'typeorm';
import { ChatTrainer } from '../../entities/chat.trainer.entity';
import { NlpManager } from 'node-nlp';
import { DomainManager } from '@nlpjs/nlu';
import * as fs from 'fs';
import { resolve, join } from 'path';
import { CreateChatTrainerDto } from '../../dto/create.chat.trainer.dto';
import { Tag } from '../../../../companies/domain/entities/tag.entity';

@Injectable()
export class ChatTrainersService {
  constructor(readonly dataSource: DataSource) {}

  async findAll(request: any): Promise<any> {
    const search = '%' + (request.query.search ?? '') + '%';
    const limit = request.query.limit ?? 25;
    const page = request.query.page ?? 1;
    const id = request.query.id ?? -1;
    const [chats, count] = await this.dataSource
      .getRepository(ChatTrainer)
      .find({
        where:
          id > 0
            ? [
                { utterance: ILike(search), id: MoreThan(id) },
                { intent: ILike(search), id: MoreThan(id) },
                { type: ILike(search), id: MoreThan(id) },
                { slot: ILike(search), id: MoreThan(id) },
                { name: ILike(search), id: MoreThan(id) },
                { command: ILike(search), id: MoreThan(id) },
              ]
            : [
                { utterance: ILike(search) },
                { intent: ILike(search) },
                { type: ILike(search) },
                { slot: ILike(search) },
                { name: ILike(search) },
                { command: ILike(search) },
              ],
        take: limit,
        skip: id > 0 ? 0 : limit * (page - 1),
      });
    return {
      data: chats,
      count: count,
    };
  }

  async add(request: any, body: CreateChatTrainerDto): Promise<ChatTrainer[]> {
    const ops = [];

    for (let i = 0; i < body.utterance.length; i++) {
      const trainer = new ChatTrainer();
      trainer.intent = body.intent;
      trainer.language = body.language;
      trainer.type = body.type;
      trainer.name = body.name;
      trainer.command = body.command;
      trainer.slot = body.slot;
      trainer.utterance = body.utterance[i];
      ops.push(this.dataSource.getRepository(ChatTrainer).save(trainer));
    }

    return await Promise.all(ops);
  }

  async addAll(
    request: any,
    bodies: CreateChatTrainerDto[],
  ): Promise<ChatTrainer[]> {
    const op = [];
    for (let i = 0; i < bodies.length; i++) {
      for (let j = 0; j < bodies[i].utterance.length; j++) {
        const trainer = new ChatTrainer();
        trainer.intent = bodies[i].intent;
        trainer.language = bodies[i].language;
        trainer.type = bodies[i].type;
        trainer.name = bodies[i].name;
        trainer.command = bodies[i].command;
        trainer.slot = bodies[i].slot;
        trainer.utterance = bodies[i].utterance[j];
        op.push(this.dataSource.getRepository(ChatTrainer).save(trainer));
      }
    }
    return await Promise.all(op);
  }

  async delete(request: any, id: number): Promise<any> {
    return await this.dataSource.getRepository(ChatTrainer).delete({
      id: id,
    });
  }

  async clearAll(): Promise<any> {
    const path = join(
      __dirname.substring(0, __dirname.lastIndexOf('dist')),
      '/linko-ai.nlp',
    );
    if (fs.existsSync(path))
      fs.unlink(path, (err) => {
        if (err) {
          throw err;
        }
        console.log('Delete File successfully.');
      });
    return await this.dataSource.getRepository(ChatTrainer).delete({
      id: MoreThan(0),
    });
  }

  async train(): Promise<any> {
    const path = join(
      __dirname.substring(0, __dirname.lastIndexOf('dist')),
      '/linko-ai.nlp',
    );
    const manager = new NlpManager({
      languages: ['en', 'ar'],
      forceNER: true,
      nlu: { useNoneFeature: false, log: true },
    });

    //train about tags entity
    const tags = await this.dataSource
      .getRepository(Tag)
      .find({ relations: ['companies'] });
    for (let i = 0; i < tags.length; i++) {
      // for (let j = 0; j < tags[i].companies.length; j++) {
      manager.addNamedEntityText(
        tags[i].name,
        tags[i].name,
        ['en'],
        [...tags[i].desc.split(','), tags[i].name.toLowerCase()],
      );
      // }
      // manager.addNamedEntityText(
      //   tags[i].type,
      //   tags[i].name,
      //   ['en'],
      //   tags[i].companies.map((c) => c.name),
      // );
    }
    manager.addAfterLastCondition('en', 'name', ['is', "I'm"]);
    const trainers = await this.dataSource.getRepository(ChatTrainer).find();
    for (let i = 0; i < trainers.length; i++) {
      if (trainers[i].command.toLowerCase().includes('document')) {
        if (trainers[i].utterance != null && trainers[i].utterance.length > 0) {
          // for (let j = 0; j < trainers[i].utterance.length; j++) {
          manager.addDocument(
            trainers[i].language,
            trainers[i].utterance,
            trainers[i].intent,
          );
          // }
        }
      } else if (trainers[i].command.toLowerCase().includes('answer')) {
        if (trainers[i].utterance != null && trainers[i].utterance.length > 0) {
          // for (let j = 0; j < trainers[i].utterance.length; j++) {
          manager.addAnswer(
            trainers[i].language,
            trainers[i].intent,
            trainers[i].utterance,
          );
          // }
        }
      } else if (trainers[i].command.toLowerCase().includes('entity')) {
        manager.addNamedEntityText(
          trainers[i].type,
          trainers[i].intent,
          [trainers[i].language],
          trainers[i].utterance,
        );
      } else if (trainers[i].command.toLowerCase().includes('slot')) {
        if (trainers[i].slot != null)
          manager.nlp.slotManager.addSlot(
            trainers[i].intent,
            trainers[i].slot,
            true,
            {
              en: trainers[i].utterance,
            },
          );
      } else if (trainers[i].command.toLowerCase().includes('domain')) {
        if (trainers[i].name != null)
          manager.assignDomain('en', trainers[i].intent, trainers[i].name);
      }
    }
    await manager.train();
    // console.log('saving to ', path);
    manager.save(path);

    //for domain
    //assigning
    // //geting domain
  }
}
