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
import { ChatDocument } from '../../../chats/domain/entities/chat.document.entity';
import { Session } from './session.entity';
import { Notification } from '../../../notifications/domain/entities/notification.entity';

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

  @OneToMany(() => Session, (session) => session.user)
  sessions: Session[];

  @OneToMany(() => Chat, (chat) => chat.sender, { nullable: true })
  @JoinColumn({ name: 'sender_' })
  chatSent?: Chat[];

  @OneToMany(() => Chat, (chat) => chat.receiver, { nullable: true })
  @JoinColumn({ name: 'receiver_' })
  chatReceived?: Chat[];

  @OneToMany(() => Notification, (notification) => notification.owner, {})
  @JoinColumn({ name: 'notifier_' })
  owned_notifications?: Notification[];

  @OneToMany(() => Notification, (notification) => notification.receiver, {
    nullable: true,
  })
  @JoinColumn({ name: 'to_notify_' })
  notifications?: Notification[];

  @OneToMany(() => ChatDocument, (chatDocument) => chatDocument.sender, {
    nullable: true,
  })
  @JoinColumn({ name: 'document_' })
  chatDocumented?: Chat[];

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;
}
