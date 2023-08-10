import * as dotenv from "dotenv";
import { DataSourceOptions } from "typeorm";
import { Tag } from "../../../../linkoai/src/modules/companies/domain/entities/tag.entity";
import { Company } from "../../../../linkoai/src/modules/companies/domain/entities/company.entity";
import { Favorite } from "../../../../linkoai/src/modules/users/domain/entities/favorite.entity";
import { Chat } from "../../../../linkoai/src/modules/chats/domain/entities/chat.entity";
import { Token } from "../../../../linkoai/src/auth/domain/entities/token.entity"; 
import { User } from "../../../../linkoai/src/modules/users/domain/entities/user.entity";

dotenv.config({ path: ".env" });

export const config = {
  type: "mysql",
  // driver: 'mysql',
  host: `${process.env.DATABASE_HOST}`,
  port: Number(process.env.DATABASE_PORT),
  username: `${process.env.DATABASE_USERNAME}`,
  password: `${process.env.DATABASE_PASSWORD}`,
  database: `${process.env.DATABASE_NAME}`,
  seeds: ["src/database/seeds/**/*{.ts,.js}"],
  factories: ["src/database/seeds/factories/**/*{.ts,.js}"],
  entities: [User, Token, Tag, Company, Favorite, Chat],
  migrations: ["./src/database/migrations/*{.ts,.js}"],
  synchronize: true,
  cli: {
    migrationsDir: "./src/database/migrations",
  },
  autoLoadEntities: true,
};
