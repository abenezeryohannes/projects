import { User } from "../../user/entity/user.entity";
import { Company } from "./company.entity";
import { TagIdentifier } from "./tag.identifier.entity";

export class Tag {
  id?: number;

  name?: string;

  type?: string;

  desc?: string;

  color?: string;

  searchCount?: number;

  canDetermine?: boolean;

  isActive?: boolean;

  companies?: Company[];

  user?: User;

  tagIdentifiers?: TagIdentifier[];

  constructor(data?: {
    id?: number;
    name?: string;
    type?: string;
    desc?: string;
    color?: string;
    canDetermine?: boolean;
    isActive?: boolean;
    searchCount?: number;
    companies?: Company[];
    user?: User;
    tagIdentifiers?: TagIdentifier[];
  }) {
    this.id = data?.id;
    this.name = data?.name;
    this.type = data?.type;
    this.desc = data?.desc;
    this.searchCount = data?.searchCount;
    this.color = data?.color;
    this.canDetermine = data?.canDetermine;
    this.isActive = data?.isActive;
    this.companies = data?.companies;
    this.user = data?.user;
    this.tagIdentifiers = data?.tagIdentifiers;
  }
}
