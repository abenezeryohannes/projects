import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';

part 'user.dto.g.dart';

@JsonSerializable()
class UserDto extends Equatable {
  int id;
  String? UID;
  String? avatar;
  String? fullName;
  String phoneNumber;
  String role;
  String language;
  String theme;
  bool isActive;
  String? localImage;

  UserDto({
    required this.id,
    this.UID,
    this.avatar,
    this.fullName,
    required this.phoneNumber,
    this.role = 'USER',
    this.language = 'en-us',
    this.theme = 'light',
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
        id,
        UID,
        avatar,
        fullName,
        phoneNumber,
        role,
        language,
        theme,
        isActive,
      ];

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  dynamic get(String propName) {
    switch (propName) {
      default:
        return fullName;
    }
  }

  static fromEntity(UserEntity? entity) {
    if (entity == null) return UserDto(id: -1, phoneNumber: '');
    return UserDto.fromJson(entity.toJson());
  }

  static Future<List<UserDto>> loadUsers(l) async {
    return List<UserDto>.from(l.map((model) => UserDto.fromJson(model)));
  }
}
