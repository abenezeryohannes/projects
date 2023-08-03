import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../user/entities/user.entity.dart';

part 'token.entity.g.dart';

@JsonSerializable()
class TokenEntity extends Equatable {
  int? id;
  String token;
  String? fcmToken;
  String role;
  DateTime until;
  UserEntity? user;

  TokenEntity(
      {this.id = -1,
      required this.token,
      this.fcmToken,
      this.role = 'USER',
      required this.until,
      this.user});

  @override
  List<Object?> get props => [id, token, fcmToken, role, until, user];

  factory TokenEntity.fromJson(Map<String, dynamic> json) =>
      _$TokenEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TokenEntityToJson(this);
}
