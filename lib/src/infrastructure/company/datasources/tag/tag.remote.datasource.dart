import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';

import '../../../../appcore/dtos/wrapper.dto.dart';
import '../../../../appcore/errors/failure.dart';
import '../../../../appcore/network/api.dart';

@lazySingleton
class TagRemoteDataSource {
  late http.Client client;

  TagRemoteDataSource({required this.client});

  Future<WrapperDto<TagEntity>?> findAll({String? search}) async {
    Map<String, String> query = <String, String>{};
    if (search != null) query.addEntries({"search": search}.entries);
    http.Response response = await client.get(
      Api.getRequestWithParams("tags/findAll", query),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    WrapperDto<TagEntity> responseDto =
        WrapperDto<TagEntity>.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }
}
