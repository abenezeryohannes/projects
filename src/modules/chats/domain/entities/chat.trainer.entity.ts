import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class ChatTrainer {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    default: 'en',
  })
  language: string;

  @Column({ nullable: true })
  type: string;

  @Column({ nullable: true })
  slot: string;

  @Column({ nullable: true })
  name: string;

  @Column({ default: 'addDocument' })
  command: string;

  @Column({ length: 1000 })
  utterance: string;

  @Column({ length: 1000 })
  intent: string;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  updatedAt: Date;
}
