import { Module } from '@nestjs/common';
import { AuthService } from './domain/services/auth.service';
import { AuthController } from './controllers/auth.controller';
import { Token } from './domain/entities/token.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthProvider } from './auth.provider';

@Module({
  imports: [TypeOrmModule.forFeature([Token])],
  exports: [TypeOrmModule],
  controllers: [AuthController],
  providers: [AuthService, AuthProvider],
})
export class AuthModule {}
