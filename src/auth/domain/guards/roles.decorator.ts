import { SetMetadata } from '@nestjs/common';
import { ROLE } from '../entities/roles';

export const Roles = (...roles: string[]) => SetMetadata('roles', roles);
