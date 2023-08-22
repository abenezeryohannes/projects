import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notice.entity.g.dart';

@JsonSerializable()
class NoticeEntity extends Equatable {
  final String? noticeFor;
  final String text;

  const NoticeEntity({this.noticeFor, required this.text});

  @override
  List<Object?> get props => [noticeFor, text];

  factory NoticeEntity.fromJson(Map<String, dynamic> json) =>
      _$NoticeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeEntityToJson(this);
}
