import { File, FileFilterCallback } from 'fastify-multer/lib/interfaces';
import { FastifyRequest } from 'fastify';
import { extname } from 'path';

export const editFileName = (
  req: FastifyRequest,
  file: File,
  callback: any,
) => {
  const name = file.originalname.split('.')[0];
  const fileExtName = extname(file.originalname);
  const randomName = Array(4)
    .fill(null)
    .map(() => Math.round(Math.random() * 16).toString(16))
    .join('');
  callback(null, `${name}-${randomName}${fileExtName}`);
};

export const imageFileFilter = (
  req: FastifyRequest,
  file: File,
  callback: FileFilterCallback,
) => {
  if (!file.originalname.match(/\.(jpg|jpeg|png|gif)$/)) {
    return callback(new Error('Only image files are allowed!'), false);
  }
  callback(null, true);
};
