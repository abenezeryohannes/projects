import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
  ManyToOne,
} from 'typeorm';
import { Company } from './company.entity';
import { User } from '../../../users/domain/entities/user.entity';

@Entity()
export class Tag {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  desc: string;

  @Column()
  color: string;

  @Column({ default: true })
  isDefault: boolean;

  @Column({ default: true })
  isActive: boolean;

  @ManyToMany((type) => Company, (company) => company.tags)
  companies: Company[];

  @ManyToOne(() => User, (user) => user.tags)
  user: User;
}
