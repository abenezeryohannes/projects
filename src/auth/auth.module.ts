import { Module } from '@nestjs/common';
import { AuthService } from './domain/services/auth.service';
import { AuthController } from './controllers/auth.controller';
import { Token } from './domain/entities/token.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthProvider } from './auth.provider';
import { UsersModule } from '../modules/users/users.module';
import { JwtModule } from '@nestjs/jwt';
import { JWT } from '../core/constants';
@Module({
  imports: [
    TypeOrmModule.forFeature([Token]),
    UsersModule,
    JwtModule.register({
      global: true,
      secret: JWT,
      signOptions: { expiresIn: '365d' },
    }),
  ],
  exports: [TypeOrmModule],
  controllers: [AuthController],
  providers: [AuthService, AuthProvider],
})
export class AuthModule {}
