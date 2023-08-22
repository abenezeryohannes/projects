import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'uid.dto.g.dart';

@JsonSerializable()
class UidDto extends Equatable {
  final int target_id;
  final String? user;
  final String? target_uuid;
  final String? url;

  const UidDto(
      {required this.target_id, this.user, this.target_uuid, this.url});
  @override
  List<Object?> get props => [target_id, user, target_uuid, url];
//
//
//
  factory UidDto.fromJson(Map<String, dynamic> json) => _$UidDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UidDtoToJson(this);
}
