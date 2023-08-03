import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';

import '../../user/entities/user.entity.dart';

part 'company.entity.g.dart';

@JsonSerializable()
class CompanyEntity extends Equatable {
  int id;
  String name;
  int userId;
  String? banner;
  String? phoneNumber;
  String? ownerPhoneNumber;
  String? deliveryTime;
  String? deliveryFee;
  String? url;
  bool isActive;

  List<TagEntity>? tags;
  UserEntity? user;
  List<FavoriteEntity>? favoritesof;

  CompanyEntity(
      {required this.id,
      required this.name,
      required this.userId,
      this.banner,
      this.phoneNumber,
      this.ownerPhoneNumber,
      this.url,
      this.deliveryFee,
      this.deliveryTime,
      this.tags,
      this.user,
      this.favoritesof,
      this.isActive = false});

  @override
  List<Object?> get props => [
        id,
        name,
        userId,
        banner,
        phoneNumber,
        ownerPhoneNumber,
        url,
        tags,
        user,
        favoritesof,
        deliveryFee,
        deliveryTime,
        isActive
      ];

  factory CompanyEntity.fromJson(Map<String, dynamic> json) =>
      _$CompanyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyEntityToJson(this);
}
