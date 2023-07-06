// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityEntity _$ActivityEntityFromJson(Map<String, dynamic> json) =>
    ActivityEntity(
      Publisher: UserEntity.fromJson(json['Publisher'] as Map<String, dynamic>),
      created: DateTime.parse(json['created'] as String),
      ActivityType: json['ActivityType'] == null
          ? null
          : ActivityTypeEntity.fromJson(
              json['ActivityType'] as Map<String, dynamic>),
      Notice: json['Notice'] == null
          ? null
          : NoticeEntity.fromJson(json['Notice'] as Map<String, dynamic>),
      Approval: json['Approval'] == null
          ? null
          : ApprovalEntity.fromJson(json['Approval'] as Map<String, dynamic>),
      Action: json['Action'] == null
          ? null
          : ActionEntity.fromJson(json['Action'] as Map<String, dynamic>),
      User: json['User'] == null
          ? null
          : UserEntity.fromJson(json['User'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityEntityToJson(ActivityEntity instance) =>
    <String, dynamic>{
      'Action': instance.Action,
      'ActivityType': instance.ActivityType,
      'User': instance.User,
      'Publisher': instance.Publisher,
      'Approval': instance.Approval,
      'created': instance.created.toIso8601String(),
      'Notice': instance.Notice,
    };
