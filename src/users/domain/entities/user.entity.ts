import { Token } from '../../../../src/auth/domain/entities/token.entity';
import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  fullName: string;

  @Column()
  phoneNumber: string;

  @Column({ default: true })
  isActive: boolean;

  @OneToMany(() => Token, (token) => token.user)
  tokens: Token[];
}
