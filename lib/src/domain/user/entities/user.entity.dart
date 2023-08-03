import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';

import '../../auth/entities/token.entity.dart';

part 'user.entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  int id;
  String? UID;
  String? avatar;
  String? fullName;
  String phoneNumber;
  String role;
  String language;
  String theme;
  bool isActive;
  List<TokenEntity>? tokens;

  List<TagEntity>? tags;
  List<CompanyEntity>? companies;
  List<FavoriteEntity>? favorites;
  List<ChatEntity>? chatSent;
  List<ChatEntity>? chatReceived;

  UserEntity(
      {required this.id,
      this.UID,
      this.avatar,
      this.fullName,
      required this.phoneNumber,
      this.role = 'USER',
      this.language = 'en-us',
      this.theme = 'light',
      this.isActive = true,
      this.tokens,
      this.tags,
      this.companies,
      this.favorites,
      this.chatSent,
      this.chatReceived});

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
        tokens,
        tags,
        companies,
        favorites,
        chatSent,
        chatReceived
      ];

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
