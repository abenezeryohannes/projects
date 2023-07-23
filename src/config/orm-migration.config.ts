import { config } from './orm.config';

import { DataSource } from 'typeorm';

// export = config;

const datasource = new DataSource(config); // config is one that is defined in datasource.config.ts file
datasource.initialize();
export default datasource;
