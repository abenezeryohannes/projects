import { Controller, Get, Query, Render, Res } from '@nestjs/common';
import { AppService } from './app.service';
import { createReadStream, existsSync } from 'fs';
import { join } from 'path';
import { Util } from './core/utils/util';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('media')
  media(@Query() query: any, @Res() res) {
    try {
      if (query.path == null) {
        throw Error('No media path specified!');
      } else if (Util.isValidHttpUrl(query.path)) {
        return res.redirect(query.path);
      } else {
        const path = join(process.cwd(), 'assets', query.path);
        if (!existsSync(path)) throw Error('media not found');
        const file = createReadStream(path);
        return res.type('image/jpg').send(file);
      }
    } catch (error) {
      const file = createReadStream(
        join(process.cwd(), 'assets', 'img', 'placeholder.jpg'),
      );
      return res.type('image/jpg').send(file);
    }
  }

  @Get()
  home(@Query() query: any, @Res() res) {
    return res.send('Hello there !');
  }

  // @Get('terms_and_conditions')
  // @Render('terms.and.condition.html')
  // termsAndConditions() {}
}
