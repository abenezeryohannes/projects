import { config } from './orm.config';

import { DataSource, DataSourceOptions } from 'typeorm';

const datasource = new DataSource(config as DataSourceOptions); // config is one that is defined in datasource.config.ts file
datasource.initialize();
export default datasource;
