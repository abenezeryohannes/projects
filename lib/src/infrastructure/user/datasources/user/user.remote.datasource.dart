import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/infrastructure/user/dtos/user.dto.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../appcore/errors/failure.dart';
import '../../../../appcore/network/api.dart';

@lazySingleton
class UserRemoteDataSource {
  late http.Client client;

  UserRemoteDataSource({required this.client});

  Future<WrapperDto<UserEntity>> edit({required UserDto userDto}) async {
    try {
      var request = http.MultipartRequest('POST', Api.request('users/edit'));

      if (userDto.localImage != null && userDto.localImage!.isNotEmpty) {
        File file = File(userDto.localImage!);
        if (!(await file.exists())) {
          throw UnExpectedFailure(message: "File not found");
        }
        String? memeTD =
            lookupMimeType(userDto.localImage!, headerBytes: [0xFF, 0xD8]);

        List<String> memes =
            memeTD == null ? ['image', 'jpg'] : memeTD.split('/');

        request.files.add(http.MultipartFile(
            'avatar',
            File(userDto.localImage!).readAsBytes().asStream(),
            File(userDto.localImage!).lengthSync(),
            filename: userDto.localImage!.split("/").last,
            contentType: MediaType(memes[0], memes[1])));
      }

      Map<String, dynamic> jsonMap = userDto.toJson();
      jsonMap.forEach((key, value) {
        if (value != null &&
            (key == 'fullName' || key == 'language' || key == 'theme')) {
          request.fields[key] = value.toString();
        }
      });

      String token = GetStorage().read('token');

      Map<String, String>? header = Api.multipartHeader(token);
      request.headers.addAll(header!);

      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      WrapperDto<UserEntity> responseDto =
          WrapperDto<UserEntity>.fromJson(json.decode(response.body));
      if (responseDto.success) {
        return responseDto;
      } else {
        throw ServerFailure(message: responseDto.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<WrapperDto<UserEntity>> find() async {
    http.Response response = await client.get(
      Api.request("users"),
      headers: Api.getHeader(GetStorage().read('token')),
    );
    WrapperDto<UserEntity> responseDto =
        WrapperDto<UserEntity>.fromJson(json.decode(response.body));
    if (responseDto.success) {
      return responseDto;
    } else {
      throw ServerFailure(message: responseDto.message);
    }
  }

  Future<WrapperDto> delete() async {
    http.Response response = await client.delete(
      Api.request("users/delete"),
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
