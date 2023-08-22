import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add.patroll.dto.g.dart';

@JsonSerializable()
class AddPatrollDto extends Equatable {
  final int qr_code_id;
  final double latitude;
  final double longitude;

  const AddPatrollDto(
      {required this.qr_code_id,
      required this.latitude,
      required this.longitude});

  @override
  List<Object?> get props => [qr_code_id, latitude, longitude];

  factory AddPatrollDto.fromJson(Map<String, dynamic> json) =>
      _$AddPatrollDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddPatrollDtoToJson(this);

  static Future<List<AddPatrollDto>> fromManyAddPatrollDtos(Iterable l) async {
    return List<AddPatrollDto>.from(
        l.map((model) => AddPatrollDto.fromJson(model)));
  }
}
