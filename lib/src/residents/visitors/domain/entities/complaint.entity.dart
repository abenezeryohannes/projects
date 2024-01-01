import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/utils.dart';
part 'complaint.entity.g.dart';

@JsonSerializable()
class ComplaintEntity {
  int? nid;
  String? uuid;
  int? vid;
  String? langcode;
  String? type;
  DateTime? revision_timestamp;
  int? revision_uid;
  String? revision_url;
  bool? status;
  int? uid;
  String? title;
  DateTime? created;
  DateTime? changed;
  bool? promote;
  bool? sticky;
  bool? default_langcode;
  bool? revision_translation_affected;
  String? body;
  String? field_complaint_category;
  String? field_complaint_type;
  bool? field_complaint_urgent;
  int? commentStatus;
  int? comment_count;
  DateTime? last_comment_timestamp;
  int? last_comment_uid;
  List<String>? field_image;
  List<int>? field_image_ids;
  int? field_complaint_category_id;
  int? vote_count_like;
  int? vote_count_angry;
  int? vote_count_laughing;
  int? vote_count_sad;
  int? vote_count_suprised;
  int? vote_count_love;

  ComplaintEntity(
      {this.nid,
      this.uuid,
      this.vid,
      this.langcode,
      this.type,
      this.revision_timestamp,
      this.revision_uid,
      this.revision_url,
      this.status,
      this.uid,
      this.title,
      this.created,
      this.changed,
      this.promote,
      this.sticky,
      this.field_complaint_category_id,
      this.default_langcode,
      this.last_comment_timestamp,
      this.revision_translation_affected,
      this.body,
      this.field_image = const [],
      this.commentStatus,
      this.field_complaint_category,
      this.field_complaint_type,
      this.field_complaint_urgent,
      this.comment_count,
      this.vote_count_angry,
      this.vote_count_laughing,
      this.vote_count_like,
      this.vote_count_love,
      this.vote_count_sad,
      this.vote_count_suprised,
      this.last_comment_uid});

  factory ComplaintEntity.fromJson(Map<String, dynamic> json) =>
      _$ComplaintEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ComplaintEntityToJson(this);

  parseImages(var parsedJson) {
    List<String> images = [];
    if ((parsedJson["field_image"] as List).isEmpty) {
      return;
    }
    for (int i = 0; i < (parsedJson["field_image"] as List).length; i++) {
      if (i == 0) field_image = [];
      images.add(parsedJson["field_image"][i]['url']);
    }
    return images;
  }

  parseImagesIds(var parsedJson) {
    List<int> image_ids = [];
    if ((parsedJson["field_image"] as List).isEmpty) {
      return;
    }
    for (int i = 0; i < (parsedJson["field_image"] as List).length; i++) {
      if (i == 0) field_image_ids = [];
      image_ids.add((parsedJson["field_image"][i]['target_id']));
    }
    return image_ids;
  }

  @override
  List<Object?> get props => [
        nid,
        uuid,
        vid,
        langcode,
        type,
        revision_timestamp,
        revision_uid,
        revision_url,
        status,
        uid,
        field_complaint_category_id,
        title,
        created,
        changed,
        promote,
        sticky,
        default_langcode,
        revision_translation_affected,
        body,
        commentStatus,
        last_comment_timestamp,
        comment_count,
        last_comment_uid,
        field_complaint_category,
        field_complaint_type,
        field_complaint_urgent,
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

  static Future<List<ComplaintEntity>> parseMany(decode) async {
    return List<ComplaintEntity>.from(
        decode.map((model) => ComplaintEntity.fromJson(model)));
  }

  static ComplaintEntity parseJSONFROMLIST(var parsedJson) {
    ComplaintEntity complaint = ComplaintEntity();

    complaint.nid =
        parsedJson["nid"] != null ? int.parse(parsedJson["nid"]) : null;

    complaint.title =
        parsedJson["title"] != null ? (parsedJson["title"]) : null;

    complaint.last_comment_timestamp =
        parsedJson["last_comment_timestamp"] != null
            ? Util.parseTimeStamp(parsedJson["last_comment_timestamp"])
            : null;

    complaint.comment_count = parsedJson["comment_count"] != null
        ? int.tryParse(parsedJson["comment_count"])
        : null;

    complaint.body = parsedJson["body"] != null ? (parsedJson["body"]) : null;

    complaint.field_complaint_category =
        parsedJson["field_complaint_category"] != null
            ? (parsedJson["field_complaint_category"])
            : null;

    complaint.field_complaint_type = parsedJson["field_complaint_type"] != null
        ? (parsedJson["field_complaint_type"])
        : null;

    complaint.field_image = [
      parsedJson["field_image"] != null
          ? ((parsedJson["field_image"].runtimeType == String)
              ? (parsedJson["field_image"])
              : (parsedJson['vid'] as List).map((e) => e.toString()).toList())
          : null
    ];

    complaint.field_complaint_urgent =
        parsedJson["field_complaint_urgent"] != null
            ? (parsedJson["field_complaint_urgent"]) == "1"
            : false;

    complaint.vote_count_like = int.tryParse(
        parsedJson["vote_count_like"] != null
            ? (parsedJson["vote_count_like"])
            : "0");

    complaint.vote_count_angry = int.tryParse(
        parsedJson["vote_count_angry"] != null
            ? (parsedJson["vote_count_angry"])
            : "0");

    complaint.vote_count_laughing = int.tryParse(
        parsedJson["vote_count_laughing"] != null
            ? (parsedJson["vote_count_laughing"])
            : "0");

    complaint.vote_count_sad = int.tryParse(parsedJson["vote_count_sad"] != null
        ? (parsedJson["vote_count_sad"])
        : "0");

    complaint.vote_count_suprised = int.tryParse(
        parsedJson["vote_count_suprised"] != null
            ? (parsedJson["vote_count_suprised"])
            : "0");

    complaint.vote_count_love = int.tryParse(
        parsedJson["vote_count_love"] != null
            ? (parsedJson["vote_count_love"])
            : "0");

    return complaint;
  }

  static ComplaintEntity parseJSON(var parsedJson) {
    ComplaintEntity complaint = ComplaintEntity();
    complaint.nid =
        parsedJson["nid"] != null && (parsedJson['nid'] as List).isNotEmpty
            ? (parsedJson["nid"][0]["value"])
            : null;

    complaint.uuid =
        parsedJson["uuid"] != null && (parsedJson['uuid'] as List).isNotEmpty
            ? (parsedJson["uuid"][0]["value"])
            : null;

    complaint.vid =
        parsedJson["vid"] != null && (parsedJson['vid'] as List).isNotEmpty
            ? (parsedJson["vid"][0]["value"])
            : null;

    complaint.langcode = parsedJson["langcode"] != null &&
            (parsedJson['langcode'] as List).isNotEmpty
        ? (parsedJson["langcode"][0]["value"])
        : null;

    complaint.type =
        parsedJson["type"] != null && (parsedJson['type'] as List).isNotEmpty
            ? (parsedJson["type"][0]["target_id"])
            : null;

    complaint.revision_timestamp = parsedJson["revision_timestamp"] != null &&
            (parsedJson['revision_timestamp'] as List).isNotEmpty
        ? (Util.ParseDate(parsedJson["revision_timestamp"][0]["value"]))
        : null;

    complaint.revision_uid = parsedJson["revision_uid"] != null &&
            (parsedJson['revision_uid'] as List).isNotEmpty
        ? (parsedJson["revision_uid"][0]["target_id"])
        : null;

    complaint.revision_url = parsedJson["revision_uid"] != null &&
            (parsedJson['revision_uid'] as List).isNotEmpty
        ? (parsedJson["revision_uid"][0]["url"])
        : null;

    complaint.status = parsedJson["status"] != null &&
            (parsedJson['status'] as List).isNotEmpty
        ? (parsedJson["status"][0]["value"])
        : null;

    complaint.uid =
        parsedJson["uid"] != null && (parsedJson['uid'] as List).isNotEmpty
            ? (parsedJson["uid"][0]["target_id"])
            : null;

    complaint.title =
        parsedJson["title"] != null && (parsedJson['title'] as List).isNotEmpty
            ? (parsedJson["title"][0]["value"])
            : null;

    complaint.created = parsedJson["created"] != null &&
            (parsedJson['created'] as List).isNotEmpty
        ? Util.ParseDate(parsedJson["created"][0]["value"])
        : null;
    complaint.changed = parsedJson["changed"] != null &&
            (parsedJson['changed'] as List).isNotEmpty
        ? Util.ParseDate(parsedJson["changed"][0]["value"])
        : null;

    complaint.promote = parsedJson["promote"] != null &&
            (parsedJson['promote'] as List).isNotEmpty
        ? (parsedJson["promote"][0]["value"])
        : null;

    complaint.sticky = parsedJson["sticky"] != null &&
            (parsedJson['sticky'] as List).isNotEmpty
        ? (parsedJson["sticky"][0]["value"])
        : null;

    complaint.default_langcode = parsedJson["default_langcode"] != null &&
            (parsedJson['default_langcode'] as List).isNotEmpty
        ? (parsedJson["default_langcode"][0]["value"])
        : null;

    complaint.revision_translation_affected =
        parsedJson["revision_translation_affected"] != null &&
                (parsedJson['revision_translation_affected'] as List).isNotEmpty
            ? (parsedJson["revision_translation_affected"][0]["value"])
            : null;

    complaint.body =
        parsedJson["body"] != null && (parsedJson['body'] as List).isNotEmpty
            ? (parsedJson["body"][0]["value"])
            : null;

    complaint.field_complaint_category =
        parsedJson["field_complaint_category"] != null &&
                (parsedJson['field_complaint_category'] as List).isNotEmpty
            ? (parsedJson["field_complaint_category"][0]["target_type"])
            : null;

    complaint.field_complaint_category_id =
        parsedJson["field_complaint_category"] != null &&
                (parsedJson['field_complaint_category'] as List).isNotEmpty
            ? (parsedJson["field_complaint_category"][0]["target_id"])
            : null;

    complaint.field_complaint_type =
        parsedJson["field_complaint_type"] != null &&
                (parsedJson['field_complaint_type'] as List).isNotEmpty
            ? (parsedJson["field_complaint_type"][0]["value"])
            : null;

    complaint.field_complaint_urgent =
        parsedJson["field_complaint_urgent"] != null &&
                (parsedJson['field_complaint_urgent'] as List).isNotEmpty
            ? (parsedJson["field_complaint_urgent"][0]["value"])
            : null;

    complaint.field_image = complaint.parseImages(parsedJson);
    complaint.field_image_ids = complaint.parseImagesIds(parsedJson);
    complaint.commentStatus = parsedJson["field_comments"] != null &&
            (parsedJson['field_comments'] as List).isNotEmpty
        ? (parsedJson["field_comments"][0]["status"])
        : null;
    complaint.comment_count = parsedJson["field_comments"] != null &&
            (parsedJson['field_comments'] as List).isNotEmpty
        ? (parsedJson["field_comments"][0]["comment_count"])
        : null;
    complaint.last_comment_uid = parsedJson["field_comments"] != null &&
            (parsedJson['field_comments'] as List).isNotEmpty
        ? (parsedJson["field_comments"][0]["last_comment_uid"])
        : null;
    return complaint;
  }
}
