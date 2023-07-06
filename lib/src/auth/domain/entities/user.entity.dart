import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final String fullName;
  final String? avatar;
  final String phoneNumber;
  final String? position;

  const UserEntity(
      {required this.fullName,
      this.avatar,
      required this.phoneNumber,
      this.position});

  @override
  List<Object?> get props =>
      [this.fullName, this.avatar, this.phoneNumber, this.position];

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  dynamic get(String propName) {
    switch (propName) {
      default:
        return fullName;
    }
  }

  static Future<List<UserEntity>> loadUsers(l) async {
    return List<UserEntity>.from(l.map((model) => UserEntity.fromJson(model)));
  }
}
