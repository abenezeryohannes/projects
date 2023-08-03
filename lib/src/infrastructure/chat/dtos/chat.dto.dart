import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat.dto.g.dart';

@JsonSerializable()
class ChatDto extends Equatable {
  String? data;
  late String type;
  int? reveiverID;
  int? senderID;
  ChatDto({this.data, this.type = 'text', receiverID, senderID});

  @override
  List<Object?> get props => [data, type];

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);
}
