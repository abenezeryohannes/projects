import 'package:json_annotation/json_annotation.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
part 'create.complaint.entity.g.dart';

@JsonSerializable()
class CreateComplaintEntity {
  String? type;
  String? title;
  List<int>? field_image;
  String? body;
  String? field_complaint_type;
  int? field_complaint_urgent;
  int? field_complaint_category;

  CreateComplaintEntity(
      {this.type = "complaint",
      this.title,
      this.field_image,
      this.body,
      this.field_complaint_type,
      this.field_complaint_urgent,
      this.field_complaint_category});

  factory CreateComplaintEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateComplaintEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateComplaintEntityToJson(this);

  @override
  List<Object?> get props => [
        type,
        title,
        field_image,
        body,
        field_complaint_type,
        field_complaint_urgent,
        field_complaint_category,
      ];
  DateTime createdAt() {
    return DateTime.now();
  }

  Map<String, dynamic> toFormBody() {
    Map<String, dynamic> formBody = {};

    //
    List<Map> type = this.type != null
        ? [
            {"target_id": (this.type)}
          ]
        : [];

    List<Map> title = this.title != null
        ? [
            {"value": (this.title)}
          ]
        : [];

    List<Map> field_image = this.field_image != null
        ? this.field_image!.map((fi) => {"target_id": (fi)}).toList()
        : [];

    List<Map> body = this.body != null
        ? [
            {"value": (this.body)}
          ]
        : [];

    List<Map> field_complaint_type = this.field_complaint_type != null
        ? [
            {"value": (this.field_complaint_type)}
          ]
        : [];

    List<Map> field_complaint_urgent = this.field_complaint_type != null
        ? [
            {"value": (this.field_complaint_urgent)}
          ]
        : [];

    List<Map> field_complaint_category = this.field_complaint_category != null
        ? [
            {"target_id": (this.field_complaint_category)}
          ]
        : [];

    if (type.isNotEmpty) {
      formBody.addEntries({'type': type}.entries);
    }
    if (title.isNotEmpty) {
      formBody.addEntries({'title': title}.entries);
    }
    if (field_image.isNotEmpty) {
      formBody.addEntries({'field_image': field_image}.entries);
    }
    if (body.isNotEmpty) {
      formBody.addEntries({'body': body}.entries);
    }
    if (field_complaint_type.isNotEmpty) {
      formBody
          .addEntries({'field_complaint_type': field_complaint_type}.entries);
    }
    if (field_complaint_urgent.isNotEmpty) {
      formBody.addEntries(
          {'field_complaint_urgent': field_complaint_urgent}.entries);
    }
    if (field_complaint_category.isNotEmpty) {
      formBody.addEntries(
          {'field_complaint_category': field_complaint_category}.entries);
    }
    return formBody;
  }

  bool validate() {
    return true;
  }

  void fromEntity(ComplaintEntity? entity) {
    type = entity?.type;
    title = entity?.title;
    // field_image = entity?.field_image;
    body = entity?.body;
    field_complaint_type = entity?.field_complaint_type;
    field_complaint_urgent = (entity?.field_complaint_urgent ?? false) ? 1 : 0;
    field_complaint_category = entity?.field_complaint_category_id;
  }

  static CreateComplaintEntity fromComplaint(ComplaintEntity r) {
    return CreateComplaintEntity(
        title: r.title,
        field_image: r.field_image_ids,
        body: r.body,
        field_complaint_type: r.field_complaint_type,
        field_complaint_urgent: (r.field_complaint_urgent ?? false) ? 1 : 0,
        field_complaint_category: r.field_complaint_category_id);
  }
}
