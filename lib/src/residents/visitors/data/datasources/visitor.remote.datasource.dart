import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/domain/entities/guest.visitation.entity.dart';

import '../../../../core/data/pagination.dto.dart';
import '../../../../core/domain/entities/guest.activity.entity.dart';
import '../../../../core/domain/entities/resident.entity.dart';
import '../../../../core/domain/entities/visitation.entity.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api.dart';
import '../../../../core/utils/utils.dart';

@lazySingleton
class VisitorRemoteDatasource {
  final http.Client client;

  const VisitorRemoteDatasource({required this.client});

  Future<Pagination<GuestVisitationEntity>>? listVisitorActvities(
      {int? page,
      int? limit,
      String? type,
      DateTime? startTime,
      DateTime? endTime}) async {
    Map<String, String> query = <String, String>{};

    // query.addEntries({'page': "${page ?? 1}"}.entries);
    // if (type != null) {
    //   query.addEntries({'type': type}.entries);
    // }

    // if (limit != null) {
    //   query.addEntries({'limit': "$limit"}.entries);
    // }

    if (startTime != null) {
      query.addEntries({
        'created\[min\]': DateFormat('yyyy-MM-dd').format(startTime)
      }.entries);
    }

    if (endTime != null) {
      query.addEntries(
          {'created\[max\]': DateFormat('yyyy-MM-dd').format(endTime)}.entries);
    }

    // if (FirebaseAuth.instance.currentUser?.uid != null) {
    //   query
    //       .addEntries({'uuid': "127031d6-ccc1-43ea-8a82-7d4ae9670db1"}.entries);
    // }

    String res = 'https://hood.pragathi.business/api/v1/guest/loglist/resident';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    final header = Api.getHeader(GetStorage().read('token') ?? 'test',
        firebaseID: FirebaseAuth.instance.currentUser?.uid);
    // firebaseID: FirebaseAuth.instance.currentUser?.uid);

    http.Response response = await client.get(url, headers: header);

    switch (response.statusCode) {
      case 200:
        return Pagination<GuestVisitationEntity>.fromJson(
            json.decode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }
  //  //

  Future<VisitationEntity>? editVisitorActivity(
      {required String targetId,
      DateTime? entranceTime,
      required VisitationEntity activity,
      DateTime? exitTime}) async {
    // ignore: null_argument_to_non_null_type
    return Future.value(null);
  }

  Future<VisitationEntity>? addVisitorActivity({
    required VisitationEntity visitation,
    required DateTime entry,
    required DateTime? exit,
  }) async {
    //
    List<Map> field_ref_apartment_unit = [
      {"target_id": (visitation.field_ref_apartment_unit)}
    ];
    List<Map> field_short_notes = [
      {"value": (visitation.field_short_notes)}
    ];
    List<Map> field_long_notes = [
      {"value": (visitation.field_long_notes)}
    ];
    List<Map> field_vehicle_identification = [
      {"value": (visitation.field_vehicle_identification)}
    ];
    List<Map> field_guest_type = [
      {"value": (visitation.field_guest_type)}
    ];

    List<Map> field_guest_freq_multiple_entry = [
      {"value": (visitation.field_guest_freq_multiple_entry)}
    ];

    List<Map> field_guest_frequent_start = [
      {
        "value": (VisitationEntity.GetFormatedDateString(
                    visitation.frequentStart()) ??
                '') +
            Util.GetTimeZoneOffset(),
        "format": "Y-m-d\\TH:i:sP"
      }
    ];

    List<Map> field_guest_frequent_end = [
      {
        "value":
            (VisitationEntity.GetFormatedDateString(visitation.frequentEnd()) ??
                    '') +
                Util.GetTimeZoneOffset(),
        "format": "Y-m-d\\TH:i:sP"
      }
    ];

    // List<Map> field_guest_entry = [
    //   {
    //     "value": DateFormat('yyyy-MM-ddTHH:mm:ss').format(entry) +
    //         Util.GetTimeZoneOffset(),
    //     "format": "Y-m-d\\TH:i:sP"
    //   }
    // ];

    var body = {
      'field_ref_apartment_unit': (field_ref_apartment_unit),
      'field_short_notes': (field_short_notes),
      'field_long_notes': (field_long_notes),
      'field_vehicle_identification': (field_vehicle_identification),
      'field_guest_type': (field_guest_type),
      // 'field_guest_entry': (field_guest_entry),
      'field_guest_freq_multiple_entry': (field_guest_freq_multiple_entry),
      // 'field_guest_frequent_start': (field_guest_frequent_start),
      // 'field_guest_frequent_end': (field_guest_frequent_end),
    };

    if (visitation.field_guest_frequent_start != null &&
        visitation.field_guest_frequent_start!.trim().isNotEmpty) {
      List<Map> st = [
        {
          "value": DateFormat('yyyy-MM-ddTHH:mm:ss')
                  .format(visitation.frequentStart()!) +
              Util.GetTimeZoneOffset(),
          "format": "Y-m-d\\TH:i:sP"
        }
      ];
      body.addEntries({'field_guest_frequent_start': st}.entries);
    }

    if (visitation.field_guest_frequent_end != null &&
        visitation.field_guest_frequent_end!.trim().isNotEmpty) {
      List<Map> st = [
        {
          "value": DateFormat('yyyy-MM-ddTHH:mm:ss')
                  .format(visitation.frequentEnd()!) +
              Util.GetTimeZoneOffset(),
          "format": "Y-m-d\\TH:i:sP"
        }
      ];
      body.addEntries({'field_guest_frequent_end': st}.entries);
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
        String? field_guest_image = null;
        if (((parsedJson["field_guest_image"]) as List).isNotEmpty) {
          field_guest_image = parsedJson["field_guest_image"][0]["value"];
        }
        String? field_guest_type = parsedJson["field_guest_type"][0]["value"];
        String? field_long_notes = parsedJson["field_long_notes"][0]["value"];
        int? field_ref_apartment_unit =
            parsedJson["field_ref_apartment_unit"][0]["target_id"];
        String? field_short_notes = parsedJson["field_short_notes"][0]["value"];

        String? field_vehicle_identification = null;
        if (((parsedJson["field_vehicle_identification"]) as List).isNotEmpty) {
          field_vehicle_identification =
              parsedJson["field_vehicle_identification"][0]["value"];
        }

        String? created = (parsedJson["created"][0]["value"]);
        String? field_guest_entry = (parsedJson["created"][0]["value"]);
        String? field_guest_exit = (parsedJson["created"][0]["value"]);

        bool field_guest_freq_multiple_entry =
            parsedJson["field_guest_freq_multiple_entry"][0]["value"];

        String? field_guest_frequent_start = null;
        if (((parsedJson["field_guest_frequent_start"]) as List).isNotEmpty) {
          parsedJson["field_guest_frequent_start"][0]["value"];
        }
        String? field_guest_frequent_end = null;
        if (((parsedJson["field_guest_frequent_end"]) as List).isNotEmpty) {
          parsedJson["field_guest_frequent_end"][0]["value"];
        }
        // DateTime? field_guest_entry = parsedJson["field_guest_entry"] != null
        //     ? Util.ParseDate(parsedJson["field_guest_entry"][0]["value"])
        //     : null;

        // DateTime? field_guest_exit = parsedJson["field_guest_exit"] != null
        //     ? Util.ParseDate(parsedJson["field_guest_exit"][0]["value"])
        //     : null;

        return VisitationEntity(
          uid: uid,
          uuid: uuid,
          id: id,
          field_guest_image: field_guest_image,
          field_guest_type: field_guest_type,
          field_long_notes: field_long_notes,
          field_ref_apartment_unit: field_ref_apartment_unit,
          field_short_notes: field_short_notes,
          field_vehicle_identification: field_vehicle_identification,
          created: created,
          field_guest_entry: field_guest_entry,
          field_guest_exit: field_guest_exit,
          field_guest_freq_multiple_entry: field_guest_freq_multiple_entry,
          field_guest_frequent_start: field_guest_frequent_start,
          field_guest_frequent_end: field_guest_frequent_end,
        );
      default:
        throw UnExpectedException(message: response.body);
    }
  }

//
//
//
//
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

    if (FirebaseAuth.instance.currentUser?.uid != null) {
      query.addEntries(
          {'uuid': "${FirebaseAuth.instance.currentUser?.uid}"}.entries);
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

  //
  //
}
