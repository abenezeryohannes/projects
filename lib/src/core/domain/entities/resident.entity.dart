import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'resident.entity.g.dart';

@JsonSerializable()
class ResidentEntity extends Equatable {
  final String? name;
  final String? uid;
  final String? unit_number;

  String? get(String _) {
    return name;
  }

  const ResidentEntity({this.name, this.uid, this.unit_number});

  @override
  List<Object?> get props => [name, uid, unit_number];

  factory ResidentEntity.fromJson(Map<String, dynamic> json) =>
      _$ResidentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ResidentEntityToJson(this);

  static Future<List<ResidentEntity>> parseMany(decode) async {
    return List<ResidentEntity>.from(
        decode.map((model) => ResidentEntity.fromJson(model)));
  }
}
