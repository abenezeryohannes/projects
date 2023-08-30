import { Favorite } from "../../user/entity/favorite.entity";
import { User } from "../../user/entity/user.entity";
import { CompanyIdentifier } from "./company.identifier.entity";
import { Tag } from "./tag.entity";

export class Company {
  id?: number;
  name?: string;
  userId?: number;
  banner?: string;
  url?: string;
  phoneNumber?: string;
  ownerPhoneNumber?: string;
  deliveryTime?: string;
  deliveryFee?: string;
  liked?: number;
  isActive?: boolean;
  badge?: string;
  badgeColor?: string;
  tags?: Tag[];
  user?: User;
  favoritesof?: Favorite[];
  companyIdentifiers?: CompanyIdentifier[];
}
