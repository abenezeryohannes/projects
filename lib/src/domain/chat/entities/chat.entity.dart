import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../user/entities/user.entity.dart';

part 'chat.entity.g.dart';

@JsonSerializable()
class ChatEntity extends Equatable {
  int id;
  String? data;
  String type;
  bool isActive;
  UserEntity? receiver;
  UserEntity? sender;
  DateTime createdAt;
  ChatEntity(
      {required this.id,
      this.data,
      this.type = 'text',
      this.isActive = true,
      this.receiver,
      this.sender,
      required this.createdAt});

  @override
  List<Object?> get props =>
      [id, data, type, isActive, receiver, sender, createdAt];

  factory ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatEntityToJson(this);
}
