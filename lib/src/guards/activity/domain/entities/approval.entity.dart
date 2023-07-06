import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../auth/domain/entities/user.entity.dart';

part 'approval.entity.g.dart';

@JsonSerializable()
class ApprovalEntity extends Equatable {
  final UserEntity approver;
  final String type;
  final int status;

  const ApprovalEntity(
      {required this.approver, this.type = 'on-spot', this.status = 0});

  factory ApprovalEntity.fromJson(Map<String, dynamic> json) =>
      _$ApprovalEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalEntityToJson(this);

  @override
  List<Object?> get props => [approver, type, status];
}
