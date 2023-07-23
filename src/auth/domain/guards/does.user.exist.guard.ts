import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { UsersService } from 'src/users/domain/services/users.service';

@Injectable()
export class DoesUserExist implements CanActivate {
  constructor(private readonly userService: UsersService) {}

  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {
    const request = context.switchToHttp().getRequest();
    return this.validateRequest(request);
  }

  async validateRequest(request) {
    let userExist = null;
    if (
      request.body.phoneNumber != undefined &&
      request.body.phoneNumber != null
    )
      userExist = await this.userService.findOneByPhoneNumber(
        request.body.phoneNumber,
      );
    if (userExist) {
      throw new ForbiddenException(
        'This user is already registered, Please try to login instead!',
      );
    }
    return true;
  }
}
