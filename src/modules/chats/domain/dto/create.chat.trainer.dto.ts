import { ChatTrainer } from '../entities/chat.trainer.entity';

export class CreateChatTrainerDto {
  language: string;

  command: string;

  type: string;

  utterance: string[];

  intent: string;

  slot: string;
  name: string;

  constructor(readonly body: any) {
    if (body.language != null || body.language != undefined)
      this.language = body.language;
    else this.language = 'en';

    if (body.command != null || body.command != undefined)
      this.command = body.command;
    else body.command = 'addDocument';

    if (body.type != null || body.type != undefined) this.type = body.type;
    if (body.slot != null || body.slot != undefined) this.slot = body.slot;
    if (body.name != null || body.name != undefined) this.name = body.name;

    if (body.utterance != null || body.utterance != undefined) {
      if (typeof body.utterance == 'string') this.utterance = [body.utterance];
      else this.utterance = body.utterance;
    } else this.utterance = ['Fallback'];

    if (body.intent != null || body.intent != undefined)
      this.intent = body.intent;
    else this.intent = 'Fallback';
  }

  // toEntity(): ChatTrainer[] {
  //   const trainer = new ChatTrainer();
  //   trainer.language = this.language;
  //   trainer.command = this.command;
  //   trainer.name = this.name;
  //   trainer.type = this.type;
  //   trainer.utterance = this.utterance;
  //   trainer.slot = this.slot;
  //   trainer.intent = this.intent;
  //   return trainer;
  // }
}
