import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add.vote.complaint.entity.g.dart';

@JsonSerializable()
class AddVoteComplaintEntity extends Equatable {
  String? type;
  String? target_type;
  String? entity_type;
  int? entity_id;
  int? value;
  String? value_type;

  AddVoteComplaintEntity(
      {this.type,
      this.entity_id,
      this.entity_type = 'node',
      this.target_type = 'vote_type',
      this.value = 1,
      this.value_type = 'points'});

  factory AddVoteComplaintEntity.fromJson(Map<String, dynamic> json) =>
      _$AddVoteComplaintEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddVoteComplaintEntityToJson(this);

  @override
  List<Object?> get props => [type, entity_id, entity_type, value, value_type];

  Map<String, dynamic> toFormBody() {
    Map<String, dynamic> formBody = {};

    List<Map> type = this.type != null
        ? [
            {"target_id": (this.type)},
            {"target_type": (target_type)}
          ]
        : [];

    List<Map> entity_type = this.entity_type != null
        ? [
            {"entity_type": (this.entity_type)}
          ]
        : [];
    List<Map> value = this.value != null
        ? [
            {"value": (this.value)}
          ]
        : [];
    List<Map> entity_id = this.entity_id != null
        ? [
            {"target_id": (this.entity_id)}
          ]
        : [];
    List<Map> value_type = this.value_type != null
        ? [
            {"value": (this.value_type)}
          ]
        : [];

    if (type.isNotEmpty) {
      formBody.addEntries({'type': type}.entries);
    }

    if (entity_type.isNotEmpty) {
      formBody.addEntries({'value': entity_type}.entries);
    }

    if (value.isNotEmpty) {
      formBody.addEntries({'value': value}.entries);
    }

    if (entity_id.isNotEmpty) {
      formBody.addEntries({'entity_id': entity_id}.entries);
    }

    if (value_type.isNotEmpty) {
      formBody.addEntries({'value_type': value_type}.entries);
    }

    return formBody;
  }
}
