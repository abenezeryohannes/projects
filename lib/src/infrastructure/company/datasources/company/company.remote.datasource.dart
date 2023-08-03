import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';

import '../../../../appcore/dtos/wrapper.dto.dart';
import '../../../../appcore/errors/failure.dart';
import '../../../../appcore/network/api.dart';
import '../../dto/company.dto.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

@lazySingleton
class CompanyRemoteDataSource {
  late http.Client client;

  CompanyRemoteDataSource({required this.client});

  Future<WrapperDto<CompanyEntity>?> add(
      {required CompanyDto companyDto}) async {
    try {
      var request = http.MultipartRequest('POST', Api.request('companies/add'));

      if (companyDto.localImage != null && companyDto.localImage!.isNotEmpty) {
        File file = File(companyDto.localImage!);
        if (!(await file.exists())) {
          throw UnExpectedFailure(message: "File not found");
        }
        String? memeTD =
            lookupMimeType(companyDto.localImage!, headerBytes: [0xFF, 0xD8]);

        List<String> memes =
            memeTD == null ? ['image', 'jpg'] : memeTD.split('/');

        request.files.add(http.MultipartFile(
            'banner',
            File(companyDto.localImage!).readAsBytes().asStream(),
            File(companyDto.localImage!).lengthSync(),
            filename: companyDto.localImage!.split("/").last,
            contentType: MediaType(memes[0], memes[1])));
      }

      Map<String, dynamic> jsonMap = companyDto.toJson();
      jsonMap.addEntries({'tags': json.encode(companyDto.tags)}.entries);
      jsonMap.forEach((key, value) {
        if (value != null &&
            key != 'banner' &&
            key != 'isActive' &&
            key != 'localImage') {
          request.fields[key] = value.toString();
        }
      });
      Map<String, String>? header =
          Api.multipartHeader(GetStorage().read('token'));
      request.headers.addAll(header!);

      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      WrapperDto<CompanyEntity> responseDto =
          WrapperDto<CompanyEntity>.fromJson(json.decode(response.body));

      if (responseDto.success) {
        return responseDto;
      } else {
        throw ServerFailure(message: responseDto.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<WrapperDto<CompanyEntity>?> edit(
      {required CompanyDto companyDto}) async {
    try {
      var request =
          http.MultipartRequest('POST', Api.request('companies/edit'));

      if (companyDto.localImage != null && companyDto.localImage!.isNotEmpty) {
        File file = File(companyDto.localImage!);
        if (!(await file.exists())) {
          throw UnExpectedFailure(message: "File not found");
        }
        String? memeTD =
            lookupMimeType(companyDto.localImage!, headerBytes: [0xFF, 0xD8]);

        List<String> memes =
            memeTD == null ? ['image', 'jpg'] : memeTD.split('/');

        request.files.add(http.MultipartFile(
            'banner',
            File(companyDto.localImage!).readAsBytes().asStream(),
            File(companyDto.localImage!).lengthSync(),
            filename: companyDto.localImage!.split("/").last,
            contentType: MediaType(memes[0], memes[1])));
      }

      Map<String, dynamic> jsonMap = companyDto.toJson();
      jsonMap.forEach((key, value) {
        if (value != null &&
            key != 'banner' &&
            key != 'isActive' &&
            key != 'localImage') {
          request.fields[key] = value.toString();
        }
      });

      Map<String, String>? header =
          Api.multipartHeader(GetStorage().read('token'));
      request.headers.addAll(header!);

      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      WrapperDto<CompanyEntity> responseDto =
          WrapperDto<CompanyEntity>.fromJson(json.decode(response.body));
      if (responseDto.success) {
        return responseDto;
      } else {
        throw ServerFailure(message: responseDto.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<WrapperDto?> delete({required CompanyEntity company}) async {
    Map<String, String> body = <String, String>{};
    body.addEntries({"id": company.id.toString()}.entries);
    http.Response response = await client.delete(
      Api.request("companies/delete"),
      body: body,
      headers: Api.getHeader(GetStorage().read('token')),
    );
    WrapperDto responseDto = WrapperDto.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<WrapperDto<CompanyEntity>?> findAll({String? search}) async {
    Map<String, String> query = <String, String>{};
    if (search != null) query.addEntries({"search": search}.entries);
    http.Response response = await client.get(
      Api.getRequestWithParams("companies/findAll", query),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    WrapperDto<CompanyEntity> responseDto =
        WrapperDto<CompanyEntity>.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }
}
