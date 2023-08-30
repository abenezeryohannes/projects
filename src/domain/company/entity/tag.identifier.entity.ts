import { Tag } from "./tag.entity";

export class TagIdentifier {
  id?: number;

  utterance?: string;

  tag?: Tag;

  constructor(data?: { id?: number; tag?: Tag }) {
    this.id = data?.id;
    this.tag = data?.tag;
  }
}
