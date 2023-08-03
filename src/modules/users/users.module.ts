import { Module } from '@nestjs/common';
import { UsersService } from './domain/services/users.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './domain/entities/user.entity';
import { usersProviders } from './users.provider';
import { FavoritesController } from './controllers/favorites/favorites.controller';
import { FavoritesService } from './domain/services/favorites/favorites.service';
import { UsersController } from './controllers/users/users.controller';

@Module({
  imports: [TypeOrmModule.forFeature([User])],
  exports: [TypeOrmModule, UsersService],
  controllers: [UsersController, FavoritesController],
  providers: [...usersProviders, UsersService, FavoritesService],
})
export class UsersModule {}
