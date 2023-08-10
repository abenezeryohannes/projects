import { define } from 'typeorm-seeding';
import { randColor, randDepartment, randText } from '@ngneat/falso';
import { Tag } from '../../../../../linkoai/src/modules/companies/domain/entities/tag.entity';
import { Chat } from '../../../../../linkoai/src/modules/chats/domain/entities/chat.entity';
// import { send } from 'process';
import { Connection } from 'typeorm';

// define(Chat, ()) => {
// //   let userSender = await connection.manager.findOne({
// //     where: {
// //       id: sender,
// //     },
// //   });

//   let sender: number = Math.abs(Math.random() * 20 + 1);
//   let receiver: number = Math.abs(Math.random() * 20 + 1);
//   let rand: number = Math.abs(Math.random() * 2 + 1);
//   const chat: Chat = new Chat();
//   chat.type = 'text';
//   chat.userId = rand == 1 ? sender : receiver;
//   return tag;
// });

//   // pet.fa
