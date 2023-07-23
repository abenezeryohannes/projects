import { registerAs } from '@nestjs/config';
import { config as dotenvConfig } from 'dotenv';
import { DataSource, DataSourceOptions } from 'typeorm';
import { config } from './orm.config';
dotenvConfig({ path: '../.env' });

// const config = {
//   type: 'mysql',
//   host: `${process.env.DATABASE_HOST}`,
//   port: `${process.env.DATABASE_PORT}`,
//   username: `${process.env.DATABASE_USERNAME}`,
//   password: `${process.env.DATABASE_PASSWORD}`,
//   database: `${process.env.DATABASE_NAME}`,
//   entities: [User, Token],
//   migrations: ['../migrations/*{.ts,.js}'],
//   cli: {
//     migrationsDir: '../migration',
//   },
//   synchronize: true,
//   autoLoadEntities: true,
// };

export default registerAs('typeorm', () => config);
export const connectionSource = new DataSource(config as DataSourceOptions);
