import { define } from "typeorm-seeding";
import { User } from "../../../../../linkoai/src/modules/users/domain/entities/user.entity";
import { randFullName, randNumber, randPhoneNumber } from "@ngneat/falso";
import { max } from "rxjs";

define(User, () => {
  const user: User = new User();
  user.fullName = randFullName();
  user.phoneNumber = randPhoneNumber();
  user.language = "en";
  user.theme = "light";
  user.role = randNumber({ min: 1, max: 2 }) > 1 ? "USER" : "ADMIN";
  user.UID = (Math.random() * 1000000000 + 1).toString();
  return user;
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
