import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.entity.g.dart';

@JsonSerializable()
class MyCountry extends Equatable {
  late String name;

  late String dial_code;
  String? emoji;
  String? code;

  MyCountry(
      {required this.name, required this.dial_code, this.emoji, this.code});

  factory MyCountry.fromJson(Map<String, dynamic> json) =>
      _$MyCountryFromJson(json);

  Map<String, dynamic> toJson() => _$MyCountryToJson(this);

  @override
  List<Object?> get props => [name, dial_code, emoji, code];
}
