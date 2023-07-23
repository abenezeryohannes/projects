import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3000);
}
bootstrap();
//"typeorm": "typeorm-ts-node-commonjs",

// "migration:run": "npm run typeorm migration:run -- -d ./src/config/typeorm.ts",
// "migration:generate": "npm run typeorm -- -d ./src/config/typeorm.ts migration:generate ./src/migrations/$npm_config_name",
// "migration:create": "npm run typeorm -- migration:create ./src/migrations/$npm_config_name",
// "migration:revert": "npm run typeorm -- -d ./src/config/typeorm.ts migration:revert",
// "typeorm": "ts-node ./node_modules/typeorm/cli",
