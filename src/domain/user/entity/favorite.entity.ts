import { Company } from "../../company/entity/company.entity";
import { User } from "./user.entity";

 
export class Favorite {
  id?: number;

  isActive?: boolean;

  user?: User;

  company?: Company;
}


