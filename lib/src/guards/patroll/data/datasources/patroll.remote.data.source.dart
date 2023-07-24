import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/errors/exceptions.dart';
import 'package:rnginfra/src/guards/patroll/data/dtos/add.patroll.dto.dart';

import '../../../../core/data/pagination.dto.dart';
import '../../../../core/network/api.dart';
import '../../domain/entitites/patroll.entity.dart';

@singleton
class PatrollRemoteDataSource {
  final http.Client client;
  const PatrollRemoteDataSource({required this.client});

  Future<bool>? addPatroll({required AddPatrollDto patroll}) async {
    Map<String, String> body = <String, String>{};

    patroll.toJson().forEach((key, value) {
      if (value != null) {
        body.addEntries({key: value.toString()}.entries);
      }
    });
    var bodyValue = patroll.toJson();

    var bodydata = json.encode(bodyValue);
    //
    String req = 'https://hood.pragathi.business/api/v1/patroll/log';
    //Api.request("patroll");
    Uri reqUri = Uri.parse(req);
    http.Response response =
        await client.post(reqUri, body: bodydata, headers: {
      "Content-Type": "application/json",
      "Firebase-ID-Token": FirebaseAuth.instance.currentUser?.uid ?? ''
    });

    switch (response.statusCode) {
      case 201:
      case 200:
        return Future.value(true);
      // return PatrollEntity.fromJson(json.decode(response.body));
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

  Future<Pagination<PatrollEntity>?>? listPatroll(
      {int? page, int? limit, DateTime? startTime, DateTime? endTime}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    if (startTime != null) {
      query.addEntries({
        'created\[min\]': DateFormat('yyyy-MM-dd').format(startTime)
      }.entries);
    }

    if (endTime != null) {
      query.addEntries(
          {'created\[max\]': DateFormat('yyyy-MM-dd').format(endTime)}.entries);
    }

    String res = 'https://hood.pragathi.business/api/v1/patroll/loglist';
    Uri url = Uri.parse(res).replace(queryParameters: query);
    // print('uri' + url.toString());
    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test'));

    switch (response.statusCode) {
      case 200:
        return Pagination<PatrollEntity>.fromJson(jsonDecode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<bool> deletePatroll({required PatrollEntity patroll}) async {
    Map<String, String> body = {'id': '${patroll.scanned_qr_code_id}'};

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
