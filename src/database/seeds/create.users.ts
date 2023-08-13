import { Factory, Seeder } from "typeorm-seeding";
import { Connection } from "typeorm";
import { User } from "../../../../linkoai/src/modules/users/domain/entities/user.entity";
import { Company } from "../../../../linkoai/src/modules/companies/domain/entities/company.entity";
import { Tag } from "../../../../linkoai/src/modules/companies/domain/entities/tag.entity";
import { randCity, randPassword, randQuote, random } from "@ngneat/falso";
import { Favorite } from "../../../../linkoai/src/modules/users/domain/entities/favorite.entity";
import { Token } from "../../../../linkoai/src/auth/domain/entities/token.entity";
import { Chat } from "../../../../linkoai/src/modules/chats/domain/entities/chat.entity";
import * as fs from "fs";
import { resolve, join } from "path";

export default class CreateUsers implements Seeder {
  public async run(factory: Factory, connection: Connection): Promise<any> {
    await connection.query("delete from company_tag_id where 1=1");
    // await connection.query('delete from tag where 1=1');
    await connection.query("delete from favorite where 1=1");
    await connection.query("delete from company where 1=1");
    await connection.query("delete from token where 1=1");
    await connection.query("delete from chat where 1=1");
    await connection.query("delete from user where 1=1");
    // return;
    await factory(User)().createMany(20);
    // await factory(Company)().createMany(20);

    // //Many To Many
    // const tags = await connection.getRepository(Tag).find();
    // const companies = await connection.getRepository(Company).find();
    // for (let i = 0; i < companies.length; i++) {
    //   const uniqueTagTypes = [];
    //   tags.forEach((tag) => {
    //     if (!uniqueTagTypes.includes(tag.type)) uniqueTagTypes.push(tag.type);
    //   });
    //   for (let j = 0; j < uniqueTagTypes.length; j++) {
    //     let ts = tags.filter(
    //       (tag) => tag.type == uniqueTagTypes[j] && !tag.canDetermine
    //     );
    //     const rand = Math.floor(Math.random() * (ts.length - 1));
    //     if (companies[i].tags == null) companies[i].tags = [ts[rand]];
    //     else companies[i].tags.push(ts[rand]);
    //   }
    //   let dts = tags.filter((tag) => tag.canDetermine);
    //   const rand = Math.floor(Math.random() * (dts.length - 1));
    //   if (companies[i].tags == null) companies[i].tags = [dts[rand]];
    //   else companies[i].tags.push(dts[rand]);
    //   companies[i].name = "1" + companies[i].name;

    //   companies[i].tags = companies[i].tags.filter((element, index) => {
    //     return companies[i].tags.indexOf(element) === index;
    //   });
    //   await connection.manager.save(companies[i]);
    // }
    // // End
    // //One ot Many
    // const users = await connection.getRepository(User).find();

    // for (let i = 0; i < users.length; i++) {
    //   const min = Math.random() * companies.length;
    //   const max = Math.random() * companies.length + min;
    //   for (let j = 0; j < companies.slice(min, max).length; j++) {
    //     const favorite = new Favorite();
    //     favorite.company = companies[j];
    //     favorite.user = users[i];
    //     await connection.manager.save(favorite);
    //   }
    // }
    // //Token

    // for (let i = 0; i < users.length; i++) {
    //   const token = new Token();
    //   token.user = users[i];
    //   token.role = users[i].role;
    //   token.fcmToken = randPassword();
    //   token.token =
    //     users[i].role.toLowerCase() == "user"
    //       ? (users[i].id + 122).toString()
    //       : (12345678 + users[i].id).toString();
    //   token.until = new Date(Date.now());
    //   token.until = new Date(token.until.getTime() + 200);
    //   await connection.manager.save(token);
    // }
    // //End
    // //Chat
    // for (let i = 0; i < users.length; i++) {
    //   for (let j = i + 1; j < users.length; j++) {
    //     const chat = new Chat();
    //     chat.sender = users[i];
    //     chat.receiver = users[j];
    //     chat.type = "text";
    //     chat.data = randQuote();
    //     // console.log('length: ' + chat.data.length);
    //     // chat.data = chat.data.substring(
    //     //   chat.data.length > 255 ? 250 : chat.data.length,
    //     // );
    //     await connection.manager.save(chat);
    //   }
    // }
  }
}
