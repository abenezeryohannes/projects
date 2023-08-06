import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import '../../../../appcore/errors/failure.dart';
import '../../../../appcore/network/api.dart';
import '../../../../domain/user/entities/favorites.entity.dart';

@lazySingleton
class FavoriteRemoteDataSource {
  late http.Client client;

  FavoriteRemoteDataSource({required this.client});

  Future<WrapperDto<FavoriteEntity>> add({required int companyID}) async {
    http.Response response = await client.post(
      Api.request("favorites/add/$companyID"),
      headers: Api.postHeader(GetStorage().read('token')),
    );
    WrapperDto<FavoriteEntity> responseDto =
        WrapperDto<FavoriteEntity>.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<WrapperDto?> delete({required FavoriteEntity favorite}) async {
    http.Response response = await client.delete(
      Api.request("favorites/delete/${favorite.id}"),
      headers: Api.postHeader(GetStorage().read('token')),
    );
    WrapperDto responseDto = WrapperDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<WrapperDto<FavoriteEntity?>?> find({required int companyID}) async {
    http.Response response = await client.get(
      Api.request("favorites/find/$companyID"),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    WrapperDto<FavoriteEntity?> responseDto =
        WrapperDto<FavoriteEntity?>.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<WrapperDto<FavoriteEntity>?> findAll(
      {int? limit, int? page, int? lastID, String? search}) async {
    Map<String, String> query = <String, String>{};
    if (search != null) query.addEntries({"search": search}.entries);
    if (page != null) query.addEntries({"page": page.toString()}.entries);
    if (limit != null) query.addEntries({"limit": limit.toString()}.entries);
    if (lastID != null) query.addEntries({"lastID": lastID.toString()}.entries);

    String token = GetStorage().read('token');
    http.Response response = await client.get(
      Api.request("favorites"),
      headers: Api.getHeader(token),
    );
    WrapperDto<FavoriteEntity> responseDto =
        WrapperDto<FavoriteEntity>.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }
}
