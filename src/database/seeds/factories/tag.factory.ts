import { define } from 'typeorm-seeding';
import { randColor, randDepartment, randText } from '@ngneat/falso';
import { Tag } from '../../../../../linkoai/src/modules/companies/domain/entities/tag.entity';

define(Tag, () => {
  const qoute = randText();
  const tag: Tag = new Tag();
  tag.color = randColor();
  tag.desc = qoute.length > 50 ? qoute : qoute.substring(0, 50);
  tag.name = randDepartment();
  return tag;
});
