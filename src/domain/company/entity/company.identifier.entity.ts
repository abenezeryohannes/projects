import { Company } from "./company.entity";

export class CompanyIdentifier {
  id?: number;

  utterance?: string;

  company?: Company;

  constructor(data?: { id?: number; company?: Company }) {
    this.id = data?.id;
    this.company = data?.company;
  }
}
