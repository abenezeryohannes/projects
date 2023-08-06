import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';

import '../../../appcore/errors/failure.dart';
import '../../../appcore/network/api.dart';

@lazySingleton
class ChatRemoteDataSource {
  late http.Client client;

  ChatRemoteDataSource({required this.client});

  Future<WrapperDto<ChatEntity>?> findAll(
      {int? id, int? page, int? limit}) async {
    Map<String, String> query = <String, String>{};
    if (id != null) query.addEntries({"id": id.toString()}.entries);
    if (page != null) query.addEntries({"page": page.toString()}.entries);
    if (limit != null) query.addEntries({"limit": limit.toString()}.entries);

    http.Response response = await client.get(
      Api.getRequestWithParams("chats", query),
      headers: Api.getHeader(GetStorage().read('token')),
    );

    WrapperDto<ChatEntity> responseDto =
        WrapperDto<ChatEntity>.fromJson(json.decode(response.body));

    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<WrapperDto?> clearAll() async {
    http.Response response = await client.delete(
      Api.request("chats/clearAll"),
      headers: Api.getHeader(GetStorage().read('token')),
    );

    WrapperDto responseDto = WrapperDto.fromJson(json.decode(response.body));

    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }
}
