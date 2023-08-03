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

@Entity()
export class Company {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

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
  deliverTime: string;

  @Column({ name: 'delivery_fee', nullable: true })
  deliveryFee: string;

  @Column({ default: true })
  isActive: boolean;

  @ManyToMany(() => Tag, {
    cascade: true,
  })
  @JoinTable({
    name: 'companies_tags',
    joinColumn: { name: 'companyId', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'tagId', referencedColumnName: 'id' },
  })
  tags: Tag[];

  @ManyToOne(() => User, (user) => user.companies)
  user: User;

  @OneToMany(() => Favorite, (favorite) => favorite.company)
  favoritesof: Favorite[];
}
