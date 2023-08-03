import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:linko/src/infrastructure/company/dto/tag.dto.dart';

part 'company.dto.g.dart';

@JsonSerializable()
class CompanyDto extends Equatable {
  int? id;
  String name;
  int? userId;
  String? banner;
  String? phoneNumber;
  String? ownerPhoneNumber;
  String? deliveryTime;
  String? deliveryFee;
  String? localImage;
  String? url;
  bool isActive;
  List<String> tags;

  CompanyDto(
      {this.id,
      required this.name,
      required this.userId,
      this.banner,
      this.phoneNumber,
      this.ownerPhoneNumber,
      this.url,
      this.deliveryFee,
      this.localImage,
      this.deliveryTime,
      this.tags = const [],
      this.isActive = false});

  @override
  List<Object?> get props => [
        id,
        name,
        localImage,
        userId,
        tags,
        banner,
        phoneNumber,
        ownerPhoneNumber,
        url,
        deliveryFee,
        deliveryTime,
        isActive
      ];

  factory CompanyDto.fromJson(Map<String, dynamic> json) =>
      _$CompanyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDtoToJson(this);

  dynamic get(String propName) {
    switch (propName) {
      default:
        return name;
    }
  }

  static Future<List<CompanyDto>> loadCompanies(l) async {
    return List<CompanyDto>.from(l.map((model) => CompanyDto.fromJson(model)));
  }
}
