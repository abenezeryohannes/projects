import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/exceptions.dart';

import '../../../../core/network/api.dart';
import '../../domain/entitites/patroll.entity.dart';

@singleton
class PatrollRemoteDataSource {
  final http.Client client;
  const PatrollRemoteDataSource({required this.client});

  Future<PatrollEntity>? addPatroll({required PatrollEntity patroll}) async {
    Map<String, String> body = <String, String>{};

    patroll.toJson().forEach((key, value) {
      if (value != null) {
        body.addEntries({key: value.toString()}.entries);
      }
    });
    final req = Api.request("patroll");
    http.Response response = await client.post(req,
        body: body, headers: Api.postHeader(GetStorage().read('token')));

    switch (response.statusCode) {
      case 200:
        return PatrollEntity.fromJson(json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<PatrollEntity>? editPatroll(
      {required int id, required PatrollEntity patroll}) async {
    Map<String, String> body = <String, String>{};

    patroll.toJson().forEach((key, value) {
      if (value != null) {
        body.addEntries({key: value.toString()}.entries);
      }
    });

    http.Response response = await (client).put(Api.request("patroll"),
        body: body, headers: Api.postHeader(GetStorage().read('token')));

    switch (response.statusCode) {
      case 200:
        return PatrollEntity.fromJson(json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<PatrollEntity>>? listPatroll(
      {int? page, int? limit, DateTime? startTime, DateTime? endTime}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("payrolls", query),
        headers: Api.getHeader(GetStorage().read('token') ?? 'test'));

    switch (response.statusCode) {
      case 200:
        return await PatrollEntity.loadPatrolls(json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<bool> deletePatroll({required PatrollEntity patroll}) async {
    Map<String, String> body = {'id': '${patroll.qr_code_id}'};

    http.Response response = await client.delete(Api.request("patroll"),
        body: body, headers: Api.postHeader(GetStorage().read('token')));

    switch (response.statusCode) {
      case 200:
        return Future.value(true);
      default:
        throw UnExpectedException(message: response.body);
    }
  }
}
