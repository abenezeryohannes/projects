import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { User } from '../../../users/domain/entities/user.entity';

@Entity()
export class Chat {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    length: 5000,
  })
  data: string;

  @Column()
  type: string;

  @Column({ nullable: true, length: 5000 })
  context: string;

  @Column({ default: true })
  isActive: boolean;

  @Column({ default: false })
  isDocumented: boolean;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  updatedAt: Date;

  @ManyToOne(() => User, (user) => user.chatReceived)
  receiver: User;

  @ManyToOne(() => User, (user) => user.chatSent)
  sender: User;
}
