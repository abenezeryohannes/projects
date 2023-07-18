import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/utils/utils.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/bloc/staff_activity_bloc.dart';
import 'package:rnginfra/src/guards/core/data/pagination.dto.dart';
import 'package:timeago/timeago.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api.dart';
import '../../domain/entities/staff.attendance.entity.dart';

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

  Future<Pagination<StaffAttendanceEntity>>? listStaffActivity(
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

    if (startTime != null) {
      query.addEntries(
          {'created[min]': DateFormat('yyyy-MM-dd').format(startTime)}.entries);
    }

    if (endTime != null) {
      query.addEntries(
          {'created[max]': DateFormat('yyyy-MM-dd').format(endTime)}.entries);
    }

    String res = 'https://hood.pragathi.business/api/v1/staff/loglist';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid ?? '123'));

    switch (response.statusCode) {
      case 200:
        return Pagination<StaffAttendanceEntity>.fromJson(
            jsonDecode(response.body));
      // return await ActivityEntity.loadActivities(json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<Pagination<UserEntity>> listStaffs(
      {int? page, int? limit, String? search, String? position}) async {
    //
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    String res = 'https://hood.pragathi.business/api/v1/staff/list';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(
        // Api.getRequestWithParams("staff/list", query),
        url,
        headers: Api.getHeader(GetStorage().read('token') ?? '123',
            firebaseID: FirebaseAuth.instance.currentUser?.uid ?? '123'));

    switch (response.statusCode) {
      case 200:
        return Pagination<UserEntity>.fromJson(jsonDecode(response.body));
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

  Future<StaffActivityEntity>? addStaffAttendance(
      {required String targetId, required DateTime time}) async {
    //
    List<Map> field_user_staff = [
      {"target_id": int.parse(targetId)}
    ];

    List<Map> field_staff_entry = [
      {
        "value": DateFormat('yyyy-MM-ddTHH:mm:ss').format(time) +
            Util.GetTimeZoneOffset(),
        "format": "Y-m-d\\TH:i:sP"
      }
    ];

    var body = {
      'field_user_staff': (field_user_staff),
      'field_staff_entry': (field_staff_entry),
    };

    //
    String req = 'https://hood.pragathi.business/entity/hoodstafflog';
    //Api.request("patroll");
    Uri reqUri = Uri.parse(req);
    http.Response response =
        await client.post(reqUri, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Firebase-ID-Token": FirebaseAuth.instance.currentUser?.uid ?? ''
    });

    switch (response.statusCode) {
      case 200:
      case 201:
        var parsedJson = jsonDecode(response.body);
        int id = parsedJson["id"][0]["value"];
        var uuid = parsedJson["uuid"][0]["value"];
        int uid = parsedJson["uid"][0]["target_id"];
        int field_user_staff = parsedJson["field_user_staff"][0]["target_id"];
        DateTime created = Util.ParseDate(parsedJson["created"][0]["value"]);
        DateTime field_staff_entry =
            Util.ParseDate(parsedJson["field_staff_entry"][0]["value"]);
        DateTime? field_staff_exit = parsedJson["field_staff_exit"] != null
            ? Util.ParseDate(parsedJson["field_staff_exit"][0]["value"])
            : null;

        return StaffActivityEntity(
            id: id,
            uuid: uuid,
            user: UserEntity(
              name: '',
              uid: uid.toString(),
            ),
            staff: UserEntity(
              name: '',
              uid: field_user_staff.toString(),
            ),
            created: created,
            staffEntry: field_staff_entry,
            staffExit: field_staff_exit);
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<StaffActivityEntity>? editStaffAttendance(
      {required String targetId,
      DateTime? exitTime,
      DateTime? entranceTime}) async {
    List<Map> field_staff_entry = entranceTime == null
        ? []
        : [
            {
              "value": DateFormat('yyyy-MM-ddTHH:mm:ss').format(entranceTime) +
                  Util.GetTimeZoneOffset(),
              "format": "Y-m-d\\TH:i:sP"
            }
          ];

    List<Map> field_staff_exit = exitTime == null
        ? []
        : [
            {
              "value": DateFormat('yyyy-MM-ddTHH:mm:ss').format(exitTime) +
                  Util.GetTimeZoneOffset(),
              "format": "Y-m-d\\TH:i:sP"
            }
          ];

    var body = {};

    if (exitTime != null) {
      body.addEntries({'field_staff_exit': field_staff_exit}.entries);
    }
    if (entranceTime != null) {
      body.addEntries({'field_staff_entry': field_staff_entry}.entries);
    }
    //
    String req = 'https://hood.pragathi.business/hoodstafflog/$targetId';
    //Api.request("patroll");
    Uri reqUri = Uri.parse(req);
    http.Response response =
        await client.patch(reqUri, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Firebase-ID-Token": FirebaseAuth.instance.currentUser?.uid ?? ''
    });

    switch (response.statusCode) {
      case 200:
      case 201:
        var parsedJson = jsonDecode(response.body);
        int id = parsedJson["id"][0]["value"];
        var uuid = parsedJson["uuid"][0]["value"];
        int uid = parsedJson["uid"][0]["target_id"];
        int field_user_staff = parsedJson["field_user_staff"][0]["target_id"];
        DateTime created = Util.ParseDate(parsedJson["created"][0]["value"]);
        DateTime field_staff_entry =
            Util.ParseDate(parsedJson["field_staff_entry"][0]["value"]);
        DateTime? field_staff_exit = parsedJson["field_staff_exit"] != null
            ? Util.ParseDate(parsedJson["field_staff_exit"][0]["value"])
            : null;

        return StaffActivityEntity(
            id: id,
            uuid: uuid,
            user: UserEntity(
              name: '',
              uid: uid.toString(),
            ),
            staff: UserEntity(
              name: '',
              uid: field_user_staff.toString(),
            ),
            created: created,
            staffEntry: field_staff_entry,
            staffExit: field_staff_exit);
      default:
        throw UnExpectedException(message: response.body);
    }
  }
}
