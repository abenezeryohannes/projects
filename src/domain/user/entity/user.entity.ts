import { Chat } from "../../chat/entity/chat.entity";
import { Company } from "../../company/entity/company.entity";
import { Tag } from "../../company/entity/tag.entity";
import { Token } from "./token.entity";
import { Favorite } from "./favorite.entity";

export class User {
  id?: number;

  UID?: string;

  avatar?: string;

  fullName?: string;

  phoneNumber?: string;

  role?: string;

  language?: string;

  theme?: string;

  isActive?: boolean;

  tokens?: Token[];

  tags?: Tag[];

  companies?: Company[];

  favorites?: Favorite[];

  chatSent?: Chat[];

  chatReceived?: Chat[];

  constructor(data: any) {
    this.id = Number(data?.id);
    this.fullName = String(data?.fullName);
    this.avatar = String(data?.avatar);
    this.UID = String(data?.UID);
    this.phoneNumber = String(data?.phoneNumber);
    this.theme = String(data?.theme);
    this.role = String(data?.role);
    this.language = String(data?.language);
    this.isActive = Boolean(data?.isActive);

    if (data?.tags != undefined && data?.tags != null)
      this.tokens = (data?.tokens).map((t: any) => new Token(t));

    // if (data?.tags != undefined && data?.tags != null)
    //   this.tags = (data?.tags).map((t: any) => new Tag(t));

    // if (data?.tags != undefined && data?.tags != null)
    //   this.companies = (data?.companies).map((t: any) => new Company(t));

    // if (data?.tags != undefined && data?.tags != null)
    //   this.favorites = (data?.favorites).map((t: any) => new Favorite(t));

    // if (data?.tags != undefined && data?.tags != null)
    //   this.chatSent = (data?.chatSent).map((t: any) => new Chat(t));

    // if (data?.tags != undefined && data?.tags != null)
    //   this.chatReceived = (data?.chatReceived).map((t: any) => new Chat(t));
  }
}
