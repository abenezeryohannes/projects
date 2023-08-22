import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time.dto.g.dart';

@JsonSerializable()
class TimeDto extends Equatable {
  final String value;
  final String format;
  const TimeDto({required this.format, required this.value});
  @override
  List<Object?> get props => [value, format];
//
//
//
  factory TimeDto.fromJson(Map<String, dynamic> json) =>
      _$TimeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TimeDtoToJson(this);
}
