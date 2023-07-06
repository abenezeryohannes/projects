import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/action.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/approval.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/notice.entity.dart';
part 'activity.entity.g.dart';

@JsonSerializable()
class ActivityEntity extends Equatable {
  ActionEntity? Action;
  ActivityTypeEntity? ActivityType;
  UserEntity? User;
  UserEntity Publisher;
  ApprovalEntity? Approval;
  DateTime created;
  NoticeEntity? Notice;

  ActivityEntity(
      {required this.Publisher,
      required this.created,
      this.ActivityType,
      this.Notice,
      this.Approval,
      this.Action,
      this.User});

  factory ActivityEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityEntityToJson(this);

  @override
  List<Object?> get props =>
      [Action, ActivityType, User, Publisher, Approval, Notice, created];

  static Future<List<ActivityEntity>> loadActivities(l) async {
    return List<ActivityEntity>.from(
        l.map((model) => ActivityEntity.fromJson(model)));
  }
}
