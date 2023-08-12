import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { exec } from 'child_process';

@Injectable()
export class AppService {
  constructor(readonly dataSource: DataSource) {}

  async clearAll(): Promise<any> {
    await this.dataSource.query('delete from company_tag_id where 1=1');
    // await connection.query('delete from tag where 1=1');
    await this.dataSource.query('delete from favorite where 1=1');
    await this.dataSource.query('delete from company where 1=1');
    await this.dataSource.query('delete from token where 1=1');
    await this.dataSource.query('delete from chat where 1=1');
    await this.dataSource.query('delete from user where 1=1');
    await this.dataSource.query('delete from chat_trainer where 1=1');
    return true;
  }

  async seed(): Promise<any> {
    const result1 = await exec('cd ../seeder && npm run seed:run');
    return result1;
  }

  getHello(): string {
    return 'Hello World!';
  }
}
