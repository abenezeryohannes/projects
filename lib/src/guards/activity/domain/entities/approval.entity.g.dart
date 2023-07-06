// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalEntity _$ApprovalEntityFromJson(Map<String, dynamic> json) =>
    ApprovalEntity(
      approver: UserEntity.fromJson(json['approver'] as Map<String, dynamic>),
      type: json['type'] as String? ?? 'on-spot',
      status: json['status'] as int? ?? 0,
    );

Map<String, dynamic> _$ApprovalEntityToJson(ApprovalEntity instance) =>
    <String, dynamic>{
      'approver': instance.approver,
      'type': instance.type,
      'status': instance.status,
    };
