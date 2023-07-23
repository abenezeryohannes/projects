import { User } from '../users/domain/entities/user.entity';
import { Token } from '../auth/domain/entities/token.entity';
import * as dotenv from 'dotenv';
import { DataSourceOptions } from 'typeorm';
import { join } from 'path';

dotenv.config({ path: '.env' });
// dotenvConfig({ path: '../.env' });

// ormconfig.ts

export const config = {
  type: 'mysql',
  host: `${process.env.DATABASE_HOST}`,
  port: Number(process.env.DATABASE_PORT),
  username: `${process.env.DATABASE_USERNAME}`,
  password: `${process.env.DATABASE_PASSWORD}`,
  database: `${process.env.DATABASE_NAME}`,
  entities: [User, Token],
  migrations: ['./migrations/*{.ts,.js}'],
  synchronize: true,
  cli: {
    migrationsDir: './migrations',
  },
  autoLoadEntities: true,
} as DataSourceOptions;
