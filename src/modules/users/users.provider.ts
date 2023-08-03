import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from '../../auth/domain/guards/roles.guard';
import { DOES_USER_EXIST_GUARD } from '../../core/constants';
import { DoesUserExist } from '../../auth/domain/guards/does.user.exist.guard';

export const usersProviders = [
  {
    provide: APP_GUARD,
    useClass: RolesGuard,
  },
  {
    provide: DOES_USER_EXIST_GUARD,
    useClass: DoesUserExist,
  },
];
