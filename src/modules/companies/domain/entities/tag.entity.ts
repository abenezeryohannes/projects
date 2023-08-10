import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
  ManyToOne,
  JoinColumn,
  JoinTable,
} from 'typeorm';
import { Company } from './company.entity';
import { User } from '../../../users/domain/entities/user.entity';

@Entity()
export class Tag {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ default: 'industry' })
  type: string;

  @Column({ length: 2000 })
  desc: string;

  @Column()
  color: string;

  @Column({ default: false })
  canDetermine: boolean;

  @Column({ default: true })
  isActive: boolean;

  @ManyToMany((type) => Company, (company) => company.tags, { nullable: true })
  @JoinTable({
    name: 'company_tag_id',
    joinColumn: {
      name: 'tagID',
      referencedColumnName: 'id',
    },
    inverseJoinColumn: {
      name: 'companyID',
      referencedColumnName: 'id',
    },
  })
  companies: Company[];

  @ManyToOne(() => User, (user) => user.tags)
  user: User;
}
