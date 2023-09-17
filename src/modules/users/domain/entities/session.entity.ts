import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { User } from './user.entity';

@Entity()
export class Session {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  start: Date;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  end: Date;

  @ManyToOne(() => User, (user) => user.sessions)
  user: User;
}
