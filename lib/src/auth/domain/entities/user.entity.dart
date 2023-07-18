import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final String name;
  final String uid;
  final String? avatar;
  final String? phoneNumber;
  final String? position;
  final String? url;
  const UserEntity(
      {this.url,
      required this.name,
      required this.uid,
      this.avatar,
      this.phoneNumber,
      this.position});

  @override
  List<Object?> get props => [name, avatar, phoneNumber, position, url];

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  dynamic get(String propName) {
    switch (propName) {
      default:
        return name;
    }
  }

  static Future<List<UserEntity>> loadUsers(l) async {
    return List<UserEntity>.from(l.map((model) => UserEntity.fromJson(model)));
  }
}
