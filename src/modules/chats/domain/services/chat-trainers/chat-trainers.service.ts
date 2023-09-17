import { Injectable } from '@nestjs/common';
import { DataSource, ILike, Like, MoreThan } from 'typeorm';
import { ChatTrainer } from '../../entities/chat.trainer.entity';
import { NlpManager } from 'node-nlp';
import { DomainManager } from '@nlpjs/nlu';
import * as fs from 'fs';
import { resolve, join } from 'path';
import { CreateChatTrainerDto } from '../../dto/create.chat.trainer.dto';
import { Tag } from '../../../../companies/domain/entities/tag.entity';
import { Company } from '../../../../companies/domain/entities/company.entity';
import { EditChatTrainerDto } from '../../dto/edit.chat.trainer.dto';

@Injectable()
export class ChatTrainersService {
  constructor(readonly dataSource: DataSource) {}

  async editUtterance(id: number, dto: EditChatTrainerDto): Promise<any> {
    let trainer = await this.dataSource.getRepository(ChatTrainer).findOne({
      where: { id: id },
    });

    // if (dto.command != null && dto.command != undefined) {
    //   trainer.command = dto.command;
    // }

    // if (dto.intent != null && dto.intent != undefined) {
    //   trainer.intent = dto.intent;
    // }

    // if (dto.language != null && dto.language != undefined) {
    //   trainer.language = dto.language;
    // }

    // if (dto.name != null && dto.name != undefined) {
    //   trainer.name = dto.name;
    // }

    // if (dto.slot != null && dto.slot != undefined) {
    //   trainer.slot = dto.slot;
    // }

    // if (dto.type != null && dto.type != undefined) {
    //   trainer.type = dto.type;
    // }
    if (dto.utterance != null && dto.utterance != undefined) {
      trainer.utterance = dto.utterance;
    }
    trainer = await this.dataSource.getRepository(ChatTrainer).save(trainer);
    return trainer;
  }

  async deleteAllUtterances(ids: number[]): Promise<any> {
    const ops = [];
    ids.forEach((id) => ops.push(this.deleteUtterance(id)));
    return await Promise.all(ops);
  }

  async deleteUtterance(id: number): Promise<any> {
    return await this.dataSource.getRepository(ChatTrainer).delete({
      id: id,
    });
  }

  async findAll(request: any): Promise<[any[], any]> {
    const search = '%' + (request.query.search ?? '') + '%';
    const limit = request.query.limit ?? 25;
    const page = request.query.page ?? 1;
    const id = request.query.id ?? -1;
    const intent = request.query.intent ?? null;
    const command = request.query.command ?? null;
    const language = request.query.language ?? null;
    const whereClause = [
      {
        utterance: ILike(search),
        intent: '%%',
      },
      {
        type: ILike(search),
        intent: '%%',
      },
      {
        slot: ILike(search),
        intent: '%%',
      },
      {
        name: ILike(search),
        intent: '%%',
      },
    ];

    if (intent != null) {
      whereClause.forEach((w) => {
        w.intent = intent;
      });
    }

    if (command != null) {
      whereClause.forEach((w) => {
        w['command'] = command;
      });
    }

    if (language != null) {
      whereClause.forEach((w) => {
        w['language'] = language;
      });
    }

    if (id > 0) {
      whereClause.forEach((w) => {
        w['id'] = MoreThan(id);
      });
    }

    const [chats, count] = await this.dataSource
      .getRepository(ChatTrainer)
      .findAndCount({
        where: whereClause,
        take: limit,
        skip: id > 0 ? 0 : limit * (page - 1),
        order: { id: 'desc' },
      });
    return [chats, count];
  }

  async findIntentAll(request: any): Promise<[any[], number]> {
    const search = '%' + (request.query.search ?? '') + '%';
    const limit = request.query.limit ?? 25;
    const page = request.query.page ?? 1;
    const id = request.query.id ?? -1;
    const result = await this.dataSource
      .getRepository(ChatTrainer)
      .createQueryBuilder('chat_trainer')
      .select('DISTINCT(chat_trainer.intent)')
      .where('chat_trainer.intent like :intent', { intent: search })
      .andWhere('chat_trainer.id > :id', { id: id })
      .limit(limit)
      .skip(id > 0 ? 0 : limit * (page - 1))
      .orderBy('intent', 'DESC')
      .getRawMany();

    const count = await this.dataSource.query(
      'SELECT COUNT(DISTINCT(chat_trainer.intent)) as result FROM linkoai.chat_trainer;',
    );
    return [result, count[0].result];
  }

  async findCommandAll(request: any): Promise<any[]> {
    const search = '%' + (request.query.search ?? '') + '%';
    const limit = request.query.limit ?? 25;
    const page = request.query.page ?? 1;
    const id = request.query.id ?? -1;
    return await this.dataSource
      .getRepository(ChatTrainer)
      .createQueryBuilder('chat_trainer')
      .select('DISTINCT(chat_trainer.command)')
      .where('chat_trainer.command like :command', { command: search })
      .andWhere('chat_trainer.id > :id', { id: id })
      .limit(limit)
      .skip(id > 0 ? 0 : limit * (page - 1))
      .orderBy('command', 'DESC')
      .getRawMany();
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

  async deleteIntent(request: any): Promise<any> {
    const intent = request.query.intent ?? null;
    if (intent == null) return true;
    return await this.dataSource.getRepository(ChatTrainer).delete({
      intent: intent,
    });
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

  async clearOnlyTraining(): Promise<any> {
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
  }

  async train(): Promise<any> {
    try {
      await this.clearOnlyTraining();
    } catch (e) {}
    //
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
      .find({ relations: ['tagIdentifiers'] });
    for (let i = 0; i < tags.length; i++) {
      // for (let j = 0; j < tags[i].companies.length; j++) {
      manager.addNamedEntityText(
        tags[i].name,
        tags[i].name,
        ['en'],
        [
          ...tags[i].tagIdentifiers
            .filter((f) => f.language != 'ar')
            .map((ti) => ti.utterance),
          tags[i].name.toLowerCase(),
        ],
      );
      if (tags[i].arabicName != null && tags[i].arabicName.trim().length > 0)
        manager.addNamedEntityText(
          tags[i].arabicName,
          tags[i].arabicName,
          ['ar'],
          [
            ...tags[i].tagIdentifiers
              .filter((f) => f.language == 'ar')
              .map((ti) => ti.utterance),
            tags[i].arabicName.toLowerCase(),
          ],
        );
    }

    //train about companies entity
    // const companies = await this.dataSource
    //   .getRepository(Company)
    //   .find({ relations: ['companyIdentifiers'] });
    // for (let i = 0; i < companies.length; i++) {
    //   // for (let j = 0; j < tags[i].companies.length; j++) {
    //   manager.addNamedEntityText(
    //     companies[i].name,
    //     companies[i].name,
    //     ['en'],
    //     [
    //       ...companies[i].companyIdentifiers
    //         .filter((f) => f.language != 'ar')
    //         .map((ci) => ci.utterance),
    //       companies[i].name.toLowerCase(),
    //     ],
    //   );
    //   manager.addNamedEntityText(
    //     companies[i].arabicName,
    //     companies[i].arabicName,
    //     ['ar'],
    //     [
    //       ...companies[i].companyIdentifiers
    //         .filter((f) => f.language == 'ar')
    //         .map((ci) => ci.utterance),
    //       companies[i].name.toLowerCase(),
    //     ],
    //   );
    // }

    ///
    // Train with chatTrainer datas
    ///
    // manager.addAfterLastCondition('en', 'name', ['is', "I'm"]);
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
          manager.assignDomain(
            trainers[i].language,
            trainers[i].intent,
            trainers[i].name,
          );
      }
    }
    await manager.train();
    manager.save(path);
  }
}
