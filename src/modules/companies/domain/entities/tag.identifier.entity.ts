import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { Tag } from './tag.entity';

@Entity()
export class TagIdentifier {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ default: 'en' })
  language: string;

  @Column()
  utterance?: string;

  @ManyToOne(() => Tag, (tag) => tag.tagIdentifiers)
  tag: Tag;
}
