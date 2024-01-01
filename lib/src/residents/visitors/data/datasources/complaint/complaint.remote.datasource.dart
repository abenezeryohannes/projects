import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/category.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/create.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';

import '../../../../../core/data/pagination.dto.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/api.dart';
import '../../../../../guards/activity/domain/entities/file.entity.dart';
import 'package:mime/mime.dart';

@lazySingleton
class ComplaintRemoteDatasource {
  final http.Client client;

  const ComplaintRemoteDatasource({required this.client});

  Future<Pagination<CategoryEntity>>? getCategories(
      {int? page, int? limit, String? search}) async {
    Map<String, String> query = <String, String>{};

    query.addEntries({'page': "${page ?? 1}"}.entries);
    if (search != null) {
      query.addEntries({'search': search}.entries);
    }

    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    String res = 'https://hood.pragathi.business/api/v1/complaint/categories';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    final header = Api.getHeader(GetStorage().read('token') ?? 'test',
        firebaseID: FirebaseAuth.instance.currentUser?.uid);
    // firebaseID: FirebaseAuth.instance.currentUser?.uid);

    http.Response response = await client.get(url, headers: header);

    switch (response.statusCode) {
      case 200:
      case 201:
        return Pagination<CategoryEntity>.fill(
            results:
                await CategoryEntity.parseMany((json.decode(response.body))));
      // case 200:
      //   return Pagination<CategoryEntity>.fill(
      //       results:
      //           await CategoryEntity.parseMany(json.decode(response.body)));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

//
  Future<ComplaintEntity>? editComplaint(
      {required String id, required CreateComplaintEntity complaint}) async {
    //
    var formBody = complaint.toFormBody();
    //
    String req = 'https://hood.pragathi.business/node/$id?_format=json';
    //Api.request("patroll");
    Uri reqUri = Uri.parse(req);
    http.Response response =
        await client.patch(reqUri, body: jsonEncode(formBody), headers: {
      "Content-Type": "application/json",
      "Firebase-ID-Token": FirebaseAuth.instance.currentUser?.uid ?? ''
    });

    switch (response.statusCode) {
      case 200:
      case 201:
        return ComplaintEntity.parseJSON(jsonDecode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

//
  Future<ComplaintEntity>? addComplaint(
      {required CreateComplaintEntity complaint}) async {
    //
    var formBody = complaint.toFormBody();
    //
    //
    String req = 'https://hood.pragathi.business/node?_format=json';
    //Api.request("patroll");
    Uri reqUri = Uri.parse(req);
    http.Response response =
        await client.post(reqUri, body: jsonEncode(formBody), headers: {
      "Content-Type": "application/json",
      "Firebase-ID-Token": FirebaseAuth.instance.currentUser?.uid ?? ''
    });

    switch (response.statusCode) {
      case 200:
      case 201:
        return ComplaintEntity.parseJSON(jsonDecode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<ComplaintEntity>? getComplaint({required String id}) async {
    String req = 'https://hood.pragathi.business/node/${id}?_format=json';
    Uri reqUri = Uri.parse(req);
    http.Response response = await client.get(reqUri,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test'));
    switch (response.statusCode) {
      case 200:
      case 201:
        return ComplaintEntity.parseJSON(jsonDecode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

//
  Future<CommentEntity>? addComment({required AddCommentEntity comment}) async {
    var formBody = comment.toFormBody();
    ////
    String req = 'https://hood.pragathi.business/comment?_format=json';
    ////
    Uri reqUri = Uri.parse(req);
    http.Response response =
        await client.post(reqUri, body: jsonEncode(formBody), headers: {
      "Content-Type": "application/json",
      "Firebase-ID-Token": FirebaseAuth.instance.currentUser?.uid ?? ''
    });

    switch (response.statusCode) {
      case 200:
      case 201:
        return CommentEntity.fromJSON(jsonDecode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  //

//
  Future<Pagination<ComplaintEntity>> getComplaints(
      {int? page, int? limit, String? search, String? categoryID}) async {
    Map<String, String> query = <String, String>{};

    if (categoryID != null) {
      query.addEntries(
          {'field_complaint_category_target_id': categoryID}.entries);
    }
    if (search != null) {
      query.addEntries({'search': search}.entries);
    }
    if (page != null) {
      query.addEntries({'page': "${page - 1}"}.entries);
    }
    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    String res = 'https://hood.pragathi.business/api/v1/complaints/list';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        final result =
            Pagination<ComplaintEntity>.fromJson(jsonDecode(response.body));
        return result;
      default:
        throw UnExpectedException(message: response.body);
    }
  }

//
  Future<Pagination<CommentEntity>> getComments(
      {required String id, int? page, int? limit, String? search}) async {
    Map<String, String> query = <String, String>{};

    if (page != null) {
      query.addEntries({'page': "${page - 1}"}.entries);
    }

    // if (limit != null) {
    //   query.addEntries({'limit': "$limit"}.entries);
    // }

    String res =
        'https://hood.pragathi.business/api/v1/complaint/${id}/comments';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        final result =
            Pagination<CommentEntity>.fromJson(jsonDecode(response.body));
        return result;
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  //
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
          'https://hood.pragathi.business/file/upload/node/complaint/field_image?_format=json');
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

  Future<VoteComplaintEntity> voteComplaint(
      AddVoteComplaintEntity addVote) async {
    var formBody = addVote.toFormBody();
    ////
    String req = 'https://hood.pragathi.business/entity/vote';
    ////
    Uri reqUri = Uri.parse(req);
    http.Response response =
        await client.post(reqUri, body: jsonEncode(formBody), headers: {
      "Content-Type": "application/json",
      "Firebase-ID-Token": FirebaseAuth.instance.currentUser?.uid ?? ''
    });

    switch (response.statusCode) {
      case 200:
      case 201:
        return VoteComplaintEntity.parseJSON(jsonDecode(response.body));
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<Pagination<ComplaintEntity>> getMyComplaints(
      {int? page, int? limit, String? search}) async {
    Map<String, String> query = <String, String>{};

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }
    if (page != null) {
      query.addEntries({'page': "${page - 1}"}.entries);
    }
    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    String res = 'https://hood.pragathi.business/api/v1/complaints/list';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        final result =
            Pagination<ComplaintEntity>.fromJson(jsonDecode(response.body));
        return result;
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<VoteComplaintEntity>> getCommentsVote(
      {int? page, int? limit, String? search}) async {
    Map<String, String> query = <String, String>{};

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }
    if (page != null) {
      query.addEntries({'page': "${page - 1}"}.entries);
    }
    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    String res = 'https://hood.pragathi.business/api/v1/comments/votelist/all';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        final result = VoteComplaintEntity.parseMany(jsonDecode(response.body));
        return result;
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<VoteComplaintEntity>> getComplaintsVote(
      {int? page, int? limit, String? search}) async {
    Map<String, String> query = <String, String>{};

    if (search != null) {
      query.addEntries({'search': search}.entries);
    }
    if (page != null) {
      query.addEntries({'page': "${page - 1}"}.entries);
    }
    if (limit != null) {
      query.addEntries({'limit': "$limit"}.entries);
    }

    String res =
        'https://hood.pragathi.business/api/v1/complaints/votelist/all';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        final result = VoteComplaintEntity.parseMany(jsonDecode(response.body));
        return result;
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<VoteComplaintEntity>> getComplaintVotes({required int id}) async {
    String res =
        'https://hood.pragathi.business/api/v1/complaints/votelist/$id';
    Uri url = Uri.parse(res);
    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        final result =
            await VoteComplaintEntity.parseMany(jsonDecode(response.body));
        return result;
      default:
        throw UnExpectedException(message: response.body);
    }
  }

  Future<List<VoteComplaintEntity>> getCommentVotes({required int id}) async {
    Map<String, String> query = <String, String>{};

    String res = 'https://hood.pragathi.business/api/v1/comments/votelist/$id';
    Uri url = Uri.parse(res).replace(queryParameters: query);

    http.Response response = await client.get(url,
        headers: Api.getHeader(GetStorage().read('token') ?? 'test',
            firebaseID: FirebaseAuth.instance.currentUser?.uid));

    switch (response.statusCode) {
      case 200:
        final result = VoteComplaintEntity.parseMany(jsonDecode(response.body));
        return result;
      default:
        throw UnExpectedException(message: response.body);
    }
  }
}
