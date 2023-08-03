import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { User } from './user.entity';
import { Company } from '../../../companies/domain/entities/company.entity';

@Entity()
export class Favorite {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ default: true })
  isActive: boolean;

  @ManyToOne(() => User, (user) => user.favorites)
  user: User;

  @ManyToOne(() => Company, (company) => company.favoritesof)
  company: Company;
}
