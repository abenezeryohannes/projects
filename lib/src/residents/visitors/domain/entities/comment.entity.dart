import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/utils.dart';
part 'comment.entity.g.dart';

@JsonSerializable()
class CommentEntity extends Equatable {
  int? cid;
  String? uuid;
  String? langcode;
  String? comment_type;
  String? subject;
  String? name;
  bool? default_langcode;
  bool? status;
  int? uid;
  int? entity_id;
  DateTime? created;
  DateTime? changed;
  String? field_name;
  String? comment_body;
  //
  //
  //
  int? vote_count_like;
  int? vote_count_angry;
  int? vote_count_laughing;
  int? vote_count_sad;
  int? vote_count_suprised;
  int? vote_count_love;

  CommentEntity({
    this.cid,
    this.uid,
    this.uuid,
    this.comment_body,
    this.comment_type,
    this.langcode,
    this.status,
    this.entity_id,
    this.created,
    this.changed,
    this.field_name,
    this.default_langcode,
    this.vote_count_angry,
    this.vote_count_laughing,
    this.vote_count_like,
    this.vote_count_love,
    this.vote_count_sad,
    this.vote_count_suprised,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CommentEntityToJson(this);

  @override
  List<Object?> get props => [
        cid,
        uid,
        uuid,
        comment_body,
        comment_type,
        langcode,
        status,
        entity_id,
        created,
        changed,
        field_name,
        default_langcode,
        vote_count_angry = 0,
        vote_count_laughing = 0,
        vote_count_like = 0,
        vote_count_love = 0,
        vote_count_sad = 0,
        vote_count_suprised = 0
      ];

  DateTime createdAt() {
    return DateTime.now();
  }

  static Future<List<CommentEntity>> parseMany(decode) async {
    return List<CommentEntity>.from(
        decode.map((model) => CommentEntity.fromJSONList(model)));
  }

  static CommentEntity fromJSONList(var parsedJson) {
    CommentEntity comment = CommentEntity();

    comment.name = parsedJson["name"] != null ? (parsedJson["name"]) : null;
    comment.comment_body = parsedJson["comment_body"] != null
        ? (parsedJson["comment_body"])
        : null;
    comment.subject = parsedJson["subject"] != null
        ? ((parsedJson["subject"].runtimeType == String)
            ? (parsedJson["subject"])
            : null)
        : null;
    comment.changed = parsedJson["changed"] != null
        ? Util.parseTimeStamp(parsedJson["changed"])
        : null;

    comment.vote_count_like = int.tryParse(parsedJson["vote_count_like"] != null
        ? (parsedJson["vote_count_like"])
        : "0");

    comment.vote_count_angry = int.tryParse(
        parsedJson["vote_count_angry"] != null
            ? (parsedJson["vote_count_angry"])
            : "0");

    comment.vote_count_laughing = int.tryParse(
        parsedJson["vote_count_laughing"] != null
            ? (parsedJson["vote_count_laughing"])
            : "0");

    comment.vote_count_sad = int.tryParse(parsedJson["vote_count_sad"] != null
        ? (parsedJson["vote_count_sad"])
        : "0");

    comment.vote_count_suprised = int.tryParse(
        parsedJson["vote_count_suprised"] != null
            ? (parsedJson["vote_count_suprised"])
            : "0");

    comment.vote_count_love = int.tryParse(parsedJson["vote_count_love"] != null
        ? (parsedJson["vote_count_love"])
        : "0");

    return comment;
  }

  static CommentEntity fromJSON(var parsedJson) {
    CommentEntity comment = CommentEntity();

    comment.cid =
        parsedJson["cid"] != null && (parsedJson['cid'] as List).isNotEmpty
            ? (parsedJson["cid"][0]["value"])
            : null;

    comment.uuid =
        parsedJson["uuid"] != null && (parsedJson['uuid'] as List).isNotEmpty
            ? (parsedJson["uuid"][0]["value"])
            : null;
    comment.langcode = parsedJson["langcode"] != null &&
            (parsedJson['langcode'] as List).isNotEmpty
        ? (parsedJson["langcode"][0]["value"])
        : null;
    comment.comment_type = parsedJson["comment_type"] != null &&
            (parsedJson['comment_type'] as List).isNotEmpty
        ? (parsedJson["comment_type"][0]["target_id"])
        : null;
    comment.status = parsedJson["status"] != null &&
            (parsedJson['status'] as List).isNotEmpty
        ? (parsedJson["status"][0]["value"])
        : null;

    comment.status = parsedJson["status"] != null &&
            (parsedJson['status'] as List).isNotEmpty
        ? (parsedJson["status"][0]["value"])
        : null;

    comment.entity_id = parsedJson["entity_id"] != null &&
            (parsedJson['entity_id'] as List).isNotEmpty
        ? (parsedJson["entity_id"][0]["target_id"])
        : null;

    comment.created = parsedJson["created"] != null &&
            (parsedJson['created'] as List).isNotEmpty
        ? Util.ParseDate(parsedJson["created"][0]["value"])
        : null;

    comment.changed = parsedJson["changed"] != null &&
            (parsedJson['changed'] as List).isNotEmpty
        ? Util.ParseDate(parsedJson["changed"][0]["value"])
        : null;

    comment.comment_body = parsedJson["comment_body"] != null &&
            (parsedJson['comment_body'] as List).isNotEmpty
        ? (parsedJson["comment_body"][0]["value"])
        : null;

    comment.default_langcode = parsedJson["default_langcode"] != null &&
            (parsedJson['default_langcode'] as List).isNotEmpty
        ? (parsedJson["default_langcode"][0]["value"])
        : null;
    return comment;
  }
}
