import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import { ValidateInputPipe } from './core/pipes/validate.pipe';
import { contentParser } from 'fastify-multer';
import 'reflect-metadata';
import { join } from 'path';

const CORS_OPTIONS = {
  origin: '*', //['http://127.0.0.1:5173', 'http://127.0.0.1:3000'], // or '*' or whatever is required
  allowedHeaders: [
    'Access-Control-Allow-Origin',
    'Origin',
    'X-Requested-With',
    'Accept',
    'Content-Type',
    'Authorization',
  ],
  exposedHeaders: 'Authorization',
  credentials: true,
  // crossOriginIsolated: false,
  methods: ['GET', 'PUT', 'OPTIONS', 'POST', 'DELETE', 'PATCH', 'HEAD'],
};

async function bootstrap() {
  const adapter = new FastifyAdapter({ bodyLimit: 10048576 });
  adapter.enableCors(CORS_OPTIONS);
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    adapter,
  );
  app.register(contentParser);
  app.setGlobalPrefix('api/v1');
  // app.useStaticAssets({
  //   root: join(__dirname, '..', '/assets/public'),
  //   prefix: 'legal',
  // });

  app.useGlobalPipes(new ValidateInputPipe());
  // const app = await NestFactory.create(AppModule);
  // app.enableCors(CORS_OPTIONS);
  await app.listen(process.env.PORT || 3000);
}
bootstrap();
