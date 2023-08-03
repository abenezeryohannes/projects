import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './auth/auth.module';
import { config } from './config/orm.config';
import { CompaniesModule } from './modules/companies/companies.module';
import { ChatsModule } from './modules/chats/chats.module';
import { MessageGateway } from './message.gateway';

@Module({
  imports: [
    TypeOrmModule.forRoot(config as TypeOrmModule),
    UsersModule,
    AuthModule,
    CompaniesModule,
    ChatsModule,
    // ServeStaticModule.forRoot({
    //   rootPath: join(__dirname, '..', 'assets/public'),
    //   exclude: ['/api*'],
    // }),
  ],
  controllers: [AppController],
  providers: [AppService, MessageGateway],
})
export class AppModule {
  constructor(private DataSource: DataSource) {}
}
