import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
part 'favorites.entity.g.dart';

@JsonSerializable()
class FavoriteEntity extends Equatable {
  int id;
  int? userId;
  int? companyId;
  bool isActive;
  CompanyEntity? company;
  UserEntity? user;
  FavoriteEntity(
      {required this.id,
      this.userId,
      this.companyId,
      this.company,
      this.user,
      this.isActive = true});

  @override
  List<Object?> get props => [id, userId, companyId, user, company, isActive];

  factory FavoriteEntity.fromJson(Map<String, dynamic> json) =>
      _$FavoriteEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteEntityToJson(this);
}
