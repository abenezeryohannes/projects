import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'field_user_staff.dto.g.dart';

@JsonSerializable()
class FieldUserStaffDto extends Equatable {
  final int target_id;
  final String? target_type;
  final String? target_uuid;
  final String? url;

  const FieldUserStaffDto(
      {this.target_type, required this.target_id, this.target_uuid, this.url});

  @override
  List<Object?> get props => [target_id, target_type, target_uuid, url];
//
//
//
  factory FieldUserStaffDto.fromJson(Map<String, dynamic> json) =>
      _$FieldUserStaffDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FieldUserStaffDtoToJson(this);
}
