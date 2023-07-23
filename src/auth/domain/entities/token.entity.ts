import { User } from '../../../../src/users/domain/entities/user.entity';
import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';

@Entity()
export class Token {
  @PrimaryGeneratedColumn()
  id: number;

  // @Column()
  // userId: number;

  @Column()
  token: string;

  @Column()
  fcmToken: string;

  @Column()
  role: string;

  @Column()
  until: Date;

  @ManyToOne(() => User, (user) => user.tokens)
  user: User;
}
