import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
  ManyToOne,
  JoinTable,
  OneToMany,
} from 'typeorm';
import { Company } from './company.entity';
import { User } from '../../../users/domain/entities/user.entity';
import { TagIdentifier } from './tag.identifier.entity';

@Entity()
export class Tag {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ nullable: true })
  arabicName: string;

  @Column({ default: 'industry' })
  type: string;

  @Column({ nullable: true })
  desc: string;

  @Column({ default: 0 })
  searchCount: number;

  @Column()
  color: string;

  @Column({ default: false })
  canDetermine: boolean;

  @Column({ default: true })
  isActive: boolean;

  @Column({ default: 0 })
  training: number;

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

  @OneToMany(() => TagIdentifier, (identifier) => identifier.tag)
  tagIdentifiers: TagIdentifier[];
}
