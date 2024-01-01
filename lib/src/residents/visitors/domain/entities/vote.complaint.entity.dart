import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/utils.dart';
part 'vote.complaint.entity.g.dart';

@JsonSerializable()
class VoteComplaintEntity extends Equatable {
  int? id;
  String? uuid;
  String? type;
  String? title;
  String? body;
  int? entity_id;
  int? value;
  int? user_id;
  DateTime? timestamp;
  String? vote_source;

  VoteComplaintEntity(
      {this.id,
      this.uuid,
      this.type,
      this.entity_id,
      this.title,
      this.body,
      this.value,
      this.user_id,
      this.vote_source});

  factory VoteComplaintEntity.fromJson(Map<String, dynamic> json) =>
      _$VoteComplaintEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoteComplaintEntityToJson(this);

  @override
  List<Object?> get props =>
      [id, uuid, type, entity_id, value, user_id, timestamp, vote_source];

  static VoteComplaintEntity parseJSON(var parsedJson) {
    VoteComplaintEntity vote = VoteComplaintEntity();
    vote.id = parsedJson["id"] != null && (parsedJson['id'] as List).isNotEmpty
        ? (parsedJson["id"][0]["value"])
        : null;

    vote.uuid =
        parsedJson["uuid"] != null && (parsedJson['uuid'] as List).isNotEmpty
            ? (parsedJson["uuid"][0]["value"])
            : null;

    vote.type =
        parsedJson["type"] != null && (parsedJson['type'] as List).isNotEmpty
            ? (parsedJson["type"][0]["target_id"])
            : null;

    vote.value =
        parsedJson["value"] != null && (parsedJson['value'] as List).isNotEmpty
            ? (parsedJson["value"][0]["value"])
            : null;

    vote.title =
        parsedJson["title"] != null && (parsedJson['title'] as List).isNotEmpty
            ? (parsedJson["title"][0]["value"])
            : null;

    vote.body =
        parsedJson["body"] != null && (parsedJson['body'] as List).isNotEmpty
            ? (parsedJson["body"][0]["value"])
            : null;

    vote.user_id = parsedJson["user_id"] != null &&
            (parsedJson['user_id'] as List).isNotEmpty
        ? (parsedJson["user_id"][0]["target_id"])
        : null;

    vote.timestamp = parsedJson["timestamp"] != null &&
            (parsedJson['timestamp'] as List).isNotEmpty
        ? (Util.ParseDate(parsedJson["timestamp"][0]["value"]))
        : null;

    vote.vote_source = parsedJson["vote_source"] != null &&
            (parsedJson['vote_source'] as List).isNotEmpty
        ? (parsedJson["vote_source"][0]["value"])
        : null;

    return vote;
  }

  static VoteComplaintEntity parseNormalJson(Map<String, dynamic> json) {
    return VoteComplaintEntity(
      id: int.tryParse(json['id']),
      uuid: json['uuid'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      entity_id: int.tryParse(json['entity_id']),
      value: int.tryParse(json['value']),
      user_id: int.tryParse(json['user_id']),
      vote_source: json['vote_source'] as String?,
    )..timestamp = json['timestamp'] == null
        ? null
        : Util.parseTimeStamp(json['timestamp'] as String);
  }

  static Future<List<VoteComplaintEntity>> parseMany(decode) async {
    return List<VoteComplaintEntity>.from(
        decode.map((model) => VoteComplaintEntity.parseNormalJson(model)));
  }
}
