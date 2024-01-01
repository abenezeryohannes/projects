import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/category.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/failure.dart';

@lazySingleton
class ComplaintLocalDatasource {
  //
  final SharedPreferences cache;

  static String COMPLAINT_KEY = 'COMPLAINT_KEY';

  static String COMMENT_KEY = 'COMMENT_KEY';

  static String CATEGORIES_KEY = 'CATEGORIES_KEY';

  final String COMMENT_VOTES = 'COMMENT_VOTES';

  final String MY_COMPLAINTs = 'MY_COMPLAINTs';

  final String COMPLAINTS_VOTE = 'COMPLAINTS_VOTE';
  final String COMPLAINT_VOTE = 'COMPLAINT_VOTE';

  final String COMMENTS_VOTE_KEY = 'COMMENTS_VOTE_KEY';

  const ComplaintLocalDatasource({required this.cache});

  Future<List<CategoryEntity>>? loadCategories({int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(CATEGORIES_KEY + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return CategoryEntity.parseMany(json.decode(data));
  }

  Future<bool>? saveCategories(int? page, result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(CATEGORIES_KEY, json.encode(result));
  }

  Future<List<ComplaintEntity>>? loadComplaints(
      {int? page, String? type, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(COMPLAINT_KEY + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return ComplaintEntity.parseMany(json.decode(data));
  }

  Future<bool>? saveComplaints(int? page, result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(COMPLAINT_KEY, json.encode(result));
  }

  Future<List<CommentEntity>>? loadComments(
      {required String id, int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(COMMENT_KEY + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return CommentEntity.parseMany(json.decode(data));
  }

  Future<bool>? saveComments(result) async {
    if (result != null) return false;
    return await cache.setString(COMMENT_KEY, json.encode(result));
  }

  Future<List<VoteComplaintEntity>>? loadCommentsVote(
      {int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(COMMENTS_VOTE_KEY + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return VoteComplaintEntity.parseMany(json.decode(data));
  }

  Future<Pagination<ComplaintEntity>>? loadMyComplaints(
      {int? page, int? limit}) async {
    if (page != null && page > 1) {
      return Pagination.fill(results: const []);
    }
    final data = cache.getString(MY_COMPLAINTs + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return Pagination<ComplaintEntity>.fill(
        results: await ComplaintEntity.parseMany(json.decode(data)));
  }

  Future<List<VoteComplaintEntity>>? loadComplaintsVote(
      {int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(COMPLAINTS_VOTE + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return VoteComplaintEntity.parseMany(json.decode(data));
  }

  Future<List<VoteComplaintEntity>>? loadCommentVotes() async {
    final data = cache.getString(COMMENT_VOTES);
    if (data == null) throw CacheFailure();
    return VoteComplaintEntity.parseMany(json.decode(data));
  }

  Future<bool> saveComplaintsVote(
      int? page, List<VoteComplaintEntity> result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(COMPLAINTS_VOTE, json.encode(result));
  }

  Future<bool> saveMyComplaints(
      int? page, Pagination<ComplaintEntity> result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(MY_COMPLAINTs, json.encode(result));
  }

  Future<bool> saveCommentVotes(List<VoteComplaintEntity> result) async {
    return await cache.setString(COMMENT_VOTES, json.encode(result));
  }

  Future<bool> saveCommentsVote(
      int? page, List<VoteComplaintEntity> result) async {
    return await cache.setString(COMMENTS_VOTE_KEY, json.encode(result));
  }

  Future<bool> saveComplaintVotes(List<VoteComplaintEntity> result) async {
    return await cache.setString(COMPLAINT_VOTE, json.encode(result));
  }
}
