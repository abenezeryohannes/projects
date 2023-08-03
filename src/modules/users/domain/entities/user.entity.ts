import { Company } from '../../../companies/domain/entities/company.entity';
import { Token } from '../../../../auth/domain/entities/token.entity';
import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  OneToMany,
  JoinColumn,
} from 'typeorm';
import { Favorite } from './favorite.entity';
import { Chat } from '../../../chats/domain/entities/chat.entity';
import { Tag } from '../../../companies/domain/entities/tag.entity';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  UID: string;

  @Column({ nullable: true })
  avatar: string;

  @Column({ nullable: true })
  fullName: string;

  @Column()
  phoneNumber: string;

  @Column({ default: 'USER' })
  role: string;

  @Column({ default: 'en-us' })
  language: string;

  @Column({ default: 'light' })
  theme: string;

  @Column({ default: true })
  isActive: boolean;

  @OneToMany(() => Token, (token) => token.user)
  tokens: Token[];

  @OneToMany(() => Tag, (tag) => tag.user)
  tags: Tag[];

  @OneToMany(() => Company, (company) => company.user)
  companies: Company[];

  @OneToMany(() => Favorite, (favorite) => favorite.user)
  favorites: Favorite[];

  @OneToMany(() => Chat, (chat) => chat.sender, { nullable: true })
  @JoinColumn({ name: 'sender_' })
  chatSent?: Chat[];

  @OneToMany(() => Chat, (chat) => chat.receiver, { nullable: true })
  @JoinColumn({ name: 'receiver_' })
  chatReceived?: Chat[];
}
