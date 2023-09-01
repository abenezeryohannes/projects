import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { Company } from './company.entity';

@Entity()
export class CompanyIdentifier {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  utterance?: string;

  @ManyToOne(() => Company, (company) => company.companyIdentifiers)
  company: Company;
}
