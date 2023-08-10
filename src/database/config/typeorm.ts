import { registerAs } from '@nestjs/config';
import { config as dotenvConfig } from 'dotenv';
import { DataSource, DataSourceOptions } from 'typeorm';
import { config } from './orm.config';
dotenvConfig({ path: '../.env' });

export default registerAs('typeorm', () => config);
export const connectionSource = new DataSource(config as DataSourceOptions);
