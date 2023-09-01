import {
  Injectable,
  CanActivate,
  ExecutionContext,
  ForbiddenException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { DataSource, IsNull } from 'typeorm';
import { Token } from '../entities/token.entity';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector, private dataSource: DataSource) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const permittedRoles = this.reflector.get<string[]>(
      'roles',
      context.getHandler(),
    );
    if (!permittedRoles) {
      return true;
    }
    const request = context.switchToHttp().getRequest();
    if (request.headers.authorization == null) {
      throw new ForbiddenException(
        'Please login or signup to make this request!',
      );
    }
    const jwt =
      request.headers.token ??
      request.headers.authorization.replace('Bearer ', '');

    let token = await this.dataSource.getRepository(Token).findOne({
      where: { token: jwt },
      relations: {
        user: true,
      },
    });

    if (token == null) return false;
    else if (token.user == null || token.user == undefined) {
      await this.dataSource.getRepository(Token).delete({ user: IsNull() });
      token = await this.dataSource.getRepository(Token).findOne({
        where: { token: jwt },
        relations: {
          user: true,
        },
      });
    } else {
      request.token = token;
      request.user = token.user;
      request.user.Token = token;
    }

    return matchRoles(token.role.toUpperCase(), permittedRoles);
  }
}

function matchRoles(
  role: string,
  permitedRoles: string[],
): boolean | Promise<boolean> {
  if (role == null) return false;
  if (permitedRoles.length == 0 || permitedRoles == null) return true;

  for (let j = 0; j < permitedRoles.length; j++) {
    if (role == permitedRoles[j]) {
      return true;
    }
  }

  return false;
}
