import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/domain/entities/guest.visitation.entity.dart';
import 'package:rnginfra/src/core/utils/utils.dart';
import 'package:rnginfra/src/core/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/core/domain/entities/resident.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';
import 'package:rnginfra/src/core/domain/entities/guest.activity.types.dart';

import '../../../../core/data/pagination.dto.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api.dart';
import '../../domain/entities/file.entity.dart';
import '../../domain/entities/staff.attendance.entity.dart';
import 'package:mime/mime.dart';

@singleton
class ActivityRemoteDatasource {
  final http.Client client;

  const ActivityRemoteDatasource({required this.client});

  Future<Pagination<GuestVisitationEntity>> listGuestActivity(
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
      query.addEntries({
        'created\[min\]': DateFormat('yyyy-MM-dd').format(startTime)
      }.entries);
    }

    if (endTime != null) {
      query.addEntries(
          {'created\[max\]': DateFormat('yyyy-MM-dd').format(endTime)}.entries);
    }

    String res = 'https://hood.pragathi.business/api/v1/guest/loglist';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        final result = Pagination<GuestVisitationEntity>.fromJson(
            jsonDecode(response.body));
        return result;
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
      query.addEntries({
        'created\[min\]': DateFormat('yyyy-MM-dd').format(startTime)
      }.entries);
    }

    if (endTime != null) {
      query.addEntries(
          {'created\[max\]': DateFormat('yyyy-MM-dd').format(endTime)}.entries);
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

    // http.Response response = await client.get(
    //     Api.getRequestWithParams("activity_types", query),
    //     headers: Api.getHeader(GetStorage().read('token') ?? 'test'));

    return GuestActivityTypes.activities;

    // switch (response.statusCode) {
    //   case 200:
    //     return await ActivityTypeEntity.loadActivityTypes(
    //         json.decode(response.body));
    //   default:
    //     throw UnExpectedException(message: response.body);
    // }
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

  Future<ActivityEntity>? editGuestActivity(
      {required String targetId,
      DateTime? entranceTime,
      required ActivityEntity activity,
      DateTime? exitTime}) async {
    //
    List<Map> field_ref_apartment_unit = [
      {"target_id": (activity.field_ref_apartment_unit)}
    ];
    List<Map> field_guest_image = [
      {"target_id": (activity.field_guest_image)}
    ];
    List<Map> field_short_notes = [
      {"value": (activity.field_short_notes)}
    ];
    List<Map> field_long_notes = [
      {"value": (activity.field_long_notes)}
    ];
    List<Map> field_vehicle_identification = [
      {"value": (activity.field_vehicle_identification)}
    ];
    List<Map> field_guest_type = [
      {"value": (activity.field_guest_type)}
    ];
    List<Map> field_guest_frequent_start = [
      {"value": (activity.field_guest_frequent_start)}
    ];
    List<Map> field_guest_frequent_end = [
      {"value": (activity.field_guest_frequent_end)}
    ];

    var body = {
      'field_ref_apartment_unit': (field_ref_apartment_unit),
      'field_short_notes': (field_short_notes),
      'field_guest_image': (field_guest_image),
      'field_long_notes': (field_long_notes),
      'field_vehicle_identification': (field_vehicle_identification),
      'field_guest_type': (field_guest_type),
    };

    if (entranceTime != null) {
      List<Map> field_guest_entry = [
        {
          "value": DateFormat('yyyy-MM-ddTHH:mm:ss').format(entranceTime) +
              Util.GetTimeZoneOffset(),
          "format": "Y-m-d\\TH:i:sP"
        }
      ];
      body.addEntries({'field_guest_entry': field_guest_entry}.entries);
    }

    if (exitTime != null) {
      List<Map> field_guest_exit = [
        {
          "value": DateFormat('yyyy-MM-ddTHH:mm:ss').format(exitTime) +
              Util.GetTimeZoneOffset(),
          "format": "Y-m-d\\TH:i:sP"
        }
      ];
      body.addEntries({'field_guest_exit': field_guest_exit}.entries);
    }

    if (activity.field_guest_frequent_start != null &&
        activity.field_guest_frequent_start!.trim().isNotEmpty) {
      List<Map> st = [
        {
          "value": DateFormat('yyyy-MM-ddTHH:mm:ss')
                  .format(activity.frequentStart()!) +
              Util.GetTimeZoneOffset(),
          "format": "Y-m-d\\TH:i:sP"
        }
      ];
      body.addEntries({'field_guest_frequent_start': st}.entries);
    }

    if (activity.field_guest_frequent_end != null &&
        activity.field_guest_frequent_end!.trim().isNotEmpty) {
      List<Map> en = [
        {
          "value": DateFormat('yyyy-MM-ddTHH:mm:ss')
                  .format(activity.frequentEnd()!) +
              Util.GetTimeZoneOffset(),
          "format": "Y-m-d\\TH:i:sP"
        }
      ];
      body.addEntries({'field_guest_frequent_end': en}.entries);
    }
    // print(jsonEncode(body));
    //
    String req = 'https://hood.pragathi.business/entity/guest_log';
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
        int uid = parsedJson["uid"][0]["target_id"];
        int id = parsedJson["id"][0]["value"];
        String? uuid = parsedJson["uuid"][0]["value"];
        int? fieldGuestImage;
        if (((parsedJson["field_guest_image"]) as List).isNotEmpty) {
          fieldGuestImage = parsedJson["field_guest_image"][0]["value"];
        }
        String? fieldGuestType = parsedJson["field_guest_type"][0]["value"];
        String? fieldLongNotes = parsedJson["field_long_notes"][0]["value"];
        int? fieldRefApartmentUnit =
            parsedJson["field_ref_apartment_unit"][0]["target_id"];
        String? fieldShortNotes = parsedJson["field_short_notes"][0]["value"];

        String? fieldVehicleIdentification;
        if (((parsedJson["field_vehicle_identification"]) as List).isNotEmpty) {
          fieldVehicleIdentification =
              parsedJson["field_vehicle_identification"][0]["value"];
        }

        String? created = (parsedJson["created"][0]["value"]);
        String? fieldGuestEntry = (parsedJson["created"][0]["value"]);
        String? fieldGuestExit = (parsedJson["created"][0]["value"]);

        // DateTime? field_guest_entry = parsedJson["field_guest_entry"] != null
        //     ? Util.ParseDate(parsedJson["field_guest_entry"][0]["value"])
        //     : null;

        // DateTime? field_guest_exit = parsedJson["field_guest_exit"] != null
        //     ? Util.ParseDate(parsedJson["field_guest_exit"][0]["value"])
        //     : null;

        return ActivityEntity(
            uid: uid,
            uuid: uuid,
            id: id,
            field_guest_image: fieldGuestImage,
            field_guest_type: fieldGuestType,
            field_long_notes: fieldLongNotes,
            field_ref_apartment_unit: fieldRefApartmentUnit,
            field_short_notes: fieldShortNotes,
            field_vehicle_identification: fieldVehicleIdentification,
            created: created,
            field_guest_entry: fieldGuestEntry,
            field_guest_exit: fieldGuestExit);
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<ActivityEntity>? addGuestActivity({
    required ActivityEntity activity,
    required DateTime entry,
    required DateTime? exit,
  }) async {
    //
    List<Map> field_ref_apartment_unit = [
      {"target_id": (activity.field_ref_apartment_unit)}
    ];
    List<Map> field_short_notes = [
      {"value": (activity.field_short_notes)}
    ];
    List<Map> field_long_notes = [
      {"value": (activity.field_long_notes)}
    ];
    List<Map> field_vehicle_identification = [
      {"value": (activity.field_vehicle_identification)}
    ];
    List<Map> field_guest_type = [
      {"value": (activity.field_guest_type)}
    ];

    List<Map> field_guest_entry = [
      {
        "value": DateFormat('yyyy-MM-ddTHH:mm:ss').format(entry) +
            Util.GetTimeZoneOffset(),
        "format": "Y-m-d\\TH:i:sP"
      }
    ];

    var body = {
      'field_ref_apartment_unit': (field_ref_apartment_unit),
      'field_short_notes': (field_short_notes),
      'field_long_notes': (field_long_notes),
      'field_vehicle_identification': (field_vehicle_identification),
      'field_guest_type': (field_guest_type),
      'field_guest_entry': (field_guest_entry),
    };
    // print(jsonEncode(body));
    //
    String req = 'https://hood.pragathi.business/entity/guest_log';
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
        int uid = parsedJson["uid"][0]["target_id"];
        int id = parsedJson["id"][0]["value"];
        String? uuid = parsedJson["uuid"][0]["value"];
        int? fieldGuestImage;
        if (((parsedJson["field_guest_image"]) as List).isNotEmpty) {
          fieldGuestImage = parsedJson["field_guest_image"][0]["value"];
        }
        String? fieldGuestType = parsedJson["field_guest_type"][0]["value"];
        String? fieldLongNotes = parsedJson["field_long_notes"][0]["value"];
        int? fieldRefApartmentUnit =
            parsedJson["field_ref_apartment_unit"][0]["target_id"];
        String? fieldShortNotes = parsedJson["field_short_notes"][0]["value"];

        String? fieldVehicleIdentification;
        if (((parsedJson["field_vehicle_identification"]) as List).isNotEmpty) {
          fieldVehicleIdentification =
              parsedJson["field_vehicle_identification"][0]["value"];
        }

        String? created = (parsedJson["created"][0]["value"]);
        String? fieldGuestEntry = (parsedJson["created"][0]["value"]);
        String? fieldGuestExit = (parsedJson["created"][0]["value"]);

        // DateTime? field_guest_entry = parsedJson["field_guest_entry"] != null
        //     ? Util.ParseDate(parsedJson["field_guest_entry"][0]["value"])
        //     : null;

        // DateTime? field_guest_exit = parsedJson["field_guest_exit"] != null
        //     ? Util.ParseDate(parsedJson["field_guest_exit"][0]["value"])
        //     : null;

        return ActivityEntity(
            uid: uid,
            uuid: uuid,
            id: id,
            field_guest_image: fieldGuestImage,
            field_guest_type: fieldGuestType,
            field_long_notes: fieldLongNotes,
            field_ref_apartment_unit: fieldRefApartmentUnit,
            field_short_notes: fieldShortNotes,
            field_vehicle_identification: fieldVehicleIdentification,
            created: created,
            field_guest_entry: fieldGuestEntry,
            field_guest_exit: fieldGuestExit);
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<Pagination<ResidentEntity>> getResidents(
      {int? page, int? limit, String? search}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    String req = 'https://hood.pragathi.business/api/v1/residents/list';
    //Api.request("patroll");
    Uri url = Uri.parse(req).replace(queryParameters: query);
    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        return Pagination<ResidentEntity>.fromJson(jsonDecode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<Pagination<GuestVisitationEntity>>? checkVisitorPasscode(
      {required String uuid}) async {
    //
    Map<String, String> query = <String, String>{};

    query.addEntries({'uuid': uuid}.entries);

    String req =
        'https://hood.pragathi.business/api/v1/guest/loglist?uuid=$uuid';

    Uri reqUri = Uri.parse(req); //.replace(queryParameters: query);

    http.Response response = await client.get(reqUri, headers: {
      "Content-Type": "application/json",
      "Firebase-ID-Token": FirebaseAuth.instance.currentUser?.uid ?? ''
    });

    switch (response.statusCode) {
      case 200:
      case 201:
        return Pagination<GuestVisitationEntity>.fromJson(
            jsonDecode(response.body));
      // ["id":"41",
      //  "created":"Mon, 07\/31\/2023 - 17:38",
      //  "guest_entry":"Mon, 07\/31\/2023 - 17:35",
      //  "guest_exit":"Thu, 07\/20\/2023 - 13:20",
      //  "guest_image":"",
      //  "guest_type":"guest",
      //  "long_notes":"ccc",
      //  "short_notes":"rrf",
      //  "vehicle_id":"",
      //  "residents":"perethec, uuvaluuadr, jecremucru",
      //  "unit_number":"473",
      //  "uuid":"127031d6-ccc1-43ea-8a82-7d4ae9670db1"]
      // var parsedJson = jsonDecode(response.body);
      // // int id = parsedJson["id"];
      // String? uuid = parsedJson["uuid"];

      // String? created = (parsedJson["created"]);
      // String? field_guest_entry = parsedJson["guest_entry"];
      // String? field_guest_exit = parsedJson["guest_exit"];
      // String? field_guest_image = null;
      // if ((parsedJson["guest_image"]) != null) {
      //   field_guest_image = parsedJson["guest_image"];
      // }
      // String? field_guest_type = parsedJson["guest_type"];
      // String? field_long_notes = parsedJson["long_notes"];
      // String? field_short_notes = parsedJson["short_notes"];
      // String? field_vehicle_identification = null;
      // if (((parsedJson["vehicle_id"]) != null)) {
      //   field_vehicle_identification = parsedJson["vehicle_id"];
      // }
      // String? residents = parsedJson["residents"];
      // String? unit_number = parsedJson["unit_number"];

      // // DateTime? field_guest_entry = parsedJson["field_guest_entry"] != null
      // //     ? Util.ParseDate(parsedJson["field_guest_entry"][0]["value"])
      // //     : null;

      // // DateTime? field_guest_exit = parsedJson["field_guest_exit"] != null
      // //     ? Util.ParseDate(parsedJson["field_guest_exit"][0]["value"])
      // //     : null;

      // return ActivityEntity(
      //     // uid: id,
      //     uuid: uuid,
      //     // id: id,
      //     field_guest_image: field_guest_image,
      //     field_guest_type: field_guest_type,
      //     field_long_notes: field_long_notes,
      //     field_short_notes: field_short_notes,
      //     field_vehicle_identification: field_vehicle_identification,
      //     created: created,
      //     field_guest_entry: field_guest_entry,
      //     field_guest_exit: field_guest_exit,
      //     residents: residents,
      //     unit_number: unit_number);
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<FileEntity?>? uploadFile({required String fileURL}) async {
    try {
      File file = File(fileURL);
      if (!(await file.exists())) {
        throw UnExpectedFailure(message: "File not found");
      }
      String? memeTD = lookupMimeType(fileURL, headerBytes: [0xFF, 0xD8]);

      List<String> memes =
          memeTD == null ? ['image', 'jpg'] : memeTD.split('/');
      //
      User? user = FirebaseAuth.instance.currentUser;
      String name = 'IMG${DateTime.now().millisecondsSinceEpoch}';
      if (user == null) return Future.value(null);

      //
      final bytes = file.readAsBytesSync();
      //
      Uri url = Uri.parse(
          'https://hood.pragathi.business/file/upload/guest_log/guest_log/field_guest_image?_format=json');
      //
      final request = http.Request('POST', url)
        ..headers['Content-Type'] = 'application/octet-stream'
        ..headers['Content-Disposition'] = 'file;filename="$name.${memes[1]}"'
        ..headers['Firebase-ID-Token'] = user.uid
        ..bodyBytes = bytes;

      http.Response response =
          await http.Response.fromStream(await request.send());
      switch (response.statusCode) {
        case 200:
        case 201:
          final result = json.decode(response.body);
          int? fid = result['fid'][0]['value'];
          String? uuid = result['uuid'][0]['value'];
          String? langcode = result['langcode'][0]['value'];
          int? uid = result['uid'][0]['target_id'];
          String? filename = result['filename'][0]['value'];
          String? url = result['uri'][0]['url'];
          String? filemime = result['filemime'][0]['value'];
          // int? size = result['filememe'][0]['filesize'][0]['value'];
          String? created = result['created'][0]['value'];
          String? changed = result['changed'][0]['value'];

          // print(result);

          return FileEntity(
            fid: fid,
            uuid: uuid,
            langcode: langcode,
            url: url,
            uid: uid,
            filemime: filemime,
            filename: filename,
            created: created,
            changed: changed,
          );
        default:
          throw ServerFailure(message: response.body);
      }
    } catch (e) {
      rethrow;
    }

    //
  }

  //
}
