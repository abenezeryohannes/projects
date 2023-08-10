import { define, factory } from 'typeorm-seeding';
import {
  randAmount,
  randAvatar,
  randCompanyName,
  randNumber,
  randPhoneNumber,
  randUrl,
} from '@ngneat/falso';
import { Company } from '../../../../../linkoai/src/modules/companies/domain/entities/company.entity';
// import { Tag } from '../../../modules/companies/domain/entities/tag.entity';

define(Company, () => {
  const company: Company = new Company();
  company.userId = Math.abs(Math.random() * 20 + 1);
  company.name = randCompanyName();
  company.banner = randAvatar();
  company.phoneNumber = randPhoneNumber();
  company.ownerPhoneNumber = randPhoneNumber();
  company.deliverTime = randNumber().toString();
  company.deliveryFee = randAmount().toString();
  company.url = randUrl();

  // company.tags = [factory(Tag)() as Tag];
  // .createMany(10)
  // .then((value) => {
  //   company.tags = value;
  // });
  //
  return company;
});

//   // pet.factory.ts
//   define(Pet, (faker: typeof Faker) => {
//     const gender = faker.random.number(1)
//     const name = faker.name.firstName(gender)

//     const pet = new Pet()
//     pet.name = name
//     pet.age = faker.random.number()
//     pet.user = factory(User)() as any
//     return pet
//   })
