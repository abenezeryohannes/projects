import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api.dart';

@singleton
class ActivityRemoteDatasource {
  final http.Client client;

  const ActivityRemoteDatasource({required this.client});

  Future<List<ActivityEntity>>? listGuestActivity(
      {int? page,
      int? limit,
      String? type,
      DateTime? startTime,
      DateTime? endTime}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);
    if (type != null) {
      query.addEntries({'type': type}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("guestActivities", query),
        headers: Api.getHeader(GetStorage().read('token') ?? 'test'));

    switch (response.statusCode) {
      case 200:
        return await ActivityEntity.loadActivities(json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<ActivityEntity>>? listStaffActivity(
      {int? page,
      int? limit,
      String? type,
      DateTime? startTime,
      DateTime? endTime}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);
    if (type != null) {
      query.addEntries({'type': type}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("staffActivities", query),
        headers: Api.getHeader(GetStorage().read('token') ?? 'test'));

    switch (response.statusCode) {
      case 200:
        return await ActivityEntity.loadActivities(json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<UserEntity>>? listStaffs(
      {int? page, int? limit, String? search, String? position}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    if (position != null) {
      query.addEntries({'position': position}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("staffs", query),
        headers: Api.getHeader(GetStorage().read('token') ?? 'test'));

    switch (response.statusCode) {
      case 200:
        return await UserEntity.loadUsers(json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<UserEntity>>? listGuests(
      {int? page, int? limit, String? search, String? activityType}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    // if (activityType != null) {
    //   query.addEntries({'activityType': activityType}.entries);
    // }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("guests", query),
        headers: Api.getHeader(GetStorage().read('token') ?? 'test'));

    switch (response.statusCode) {
      case 200:
        return await UserEntity.loadUsers(json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<ActivityTypeEntity>>? listActivityTypes(
      {int? page, int? limit, String? search}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    http.Response response = await client.get(
        Api.getRequestWithParams("activity_types", query),
        headers: Api.getHeader(GetStorage().read('token') ?? 'test'));

    switch (response.statusCode) {
      case 200:
        return await ActivityTypeEntity.loadActivityTypes(
            json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }
}
