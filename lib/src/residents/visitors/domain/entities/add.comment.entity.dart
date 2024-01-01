import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add.comment.entity.g.dart';

@JsonSerializable()
class AddCommentEntity extends Equatable {
  String? comment_type;
  String? entity_type;
  String? field_name;
  int? entity_id;
  String? comment_body;

  AddCommentEntity(
      {this.comment_type = 'comment',
      this.comment_body,
      this.entity_type = 'node',
      this.entity_id,
      this.field_name = 'field_comments'});

  factory AddCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$AddCommentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentEntityToJson(this);

  @override
  List<Object?> get props =>
      [comment_type, comment_body, entity_type, field_name, entity_id];

  DateTime createdAt() {
    return DateTime.now();
  }

  Map<String, dynamic> toFormBody() {
    Map<String, dynamic> formBody = {};

    List<Map> comment_type = this.comment_type != null
        ? [
            {"target_id": (this.comment_type)}
          ]
        : [];

    List<Map> entity_type = this.entity_type != null
        ? [
            {"value": (this.entity_type)}
          ]
        : [];
    List<Map> field_name = this.field_name != null
        ? [
            {"value": (this.field_name)}
          ]
        : [];
    List<Map> entity_id = this.entity_id != null
        ? [
            {"target_id": (this.entity_id)}
          ]
        : [];
    List<Map> comment_body = this.comment_body != null
        ? [
            {"value": (this.comment_body)}
          ]
        : [];

    if (comment_type.isNotEmpty) {
      formBody.addEntries({'comment_type': comment_type}.entries);
    }

    if (entity_type.isNotEmpty) {
      formBody.addEntries({'entity_type': entity_type}.entries);
    }

    if (field_name.isNotEmpty) {
      formBody.addEntries({'field_name': field_name}.entries);
    }

    if (entity_id.isNotEmpty) {
      formBody.addEntries({'entity_id': entity_id}.entries);
    }

    if (comment_body.isNotEmpty) {
      formBody.addEntries({'comment_body': comment_body}.entries);
    }

    return formBody;
  }
}
