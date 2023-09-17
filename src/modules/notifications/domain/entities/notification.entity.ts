import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { User } from '../../../users/domain/entities/user.entity';

@Entity()
export class Notification {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column({
    length: 5000,
  })
  message: string;

  @Column()
  arabicTitle: string;

  @Column({
    length: 5000,
  })
  arabicMessage: string;

  @Column({ default: false })
  seen: boolean;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  updatedAt: Date;

  @ManyToOne(() => User, (user) => user.notifications)
  receiver: User;

  @ManyToOne(() => User, (user) => user.owned_notifications)
  owner: User;
}
