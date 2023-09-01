import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
  JoinTable,
  ManyToOne,
  OneToMany,
} from 'typeorm';
import { Tag } from './tag.entity';
import { User } from '../../../users/domain/entities/user.entity';
import { Favorite } from '../../../users/domain/entities/favorite.entity';
import { CompanyIdentifier } from './company.identifier.entity';

@Entity()
export class Company {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ nullable: true })
  arabicName: string;

  @Column({ name: 'user_id' })
  userId: number;

  @Column({ nullable: true })
  banner: string;

  @Column({ nullable: true })
  url: string;

  @Column({ name: 'phone_number', nullable: true })
  phoneNumber: string;

  @Column({ name: 'owner_phone_number', nullable: true })
  ownerPhoneNumber: string;

  @Column({ name: 'delivery_time', nullable: true })
  deliveryTime: string;

  @Column({ name: 'delivery_fee', nullable: true })
  deliveryFee: string;

  @Column({ default: 0 })
  liked: number;

  @Column({ default: true })
  isActive: boolean;

  @Column({ name: 'badge', nullable: true })
  badge: string;

  @Column({ name: 'badge_color', nullable: true })
  badgeColor: string;

  @ManyToMany(() => Tag, (tag) => tag.companies, {
    nullable: true,
    cascade: true,
  })
  // @JoinTable({
  //   name: 'company_tag_id',
  //   joinColumn: { name: 'companyId', referencedColumnName: 'id' },
  //   inverseJoinColumn: { name: 'tagId', referencedColumnName: 'id' },
  // })
  tags: Tag[];

  @ManyToOne(() => User, (user) => user.companies)
  user: User;

  @OneToMany(() => Favorite, (favorite) => favorite.company)
  favoritesof: Favorite[];

  @OneToMany(() => CompanyIdentifier, (identifier) => identifier.company)
  companyIdentifiers: CompanyIdentifier[];

  //companyIdentifiers
}
