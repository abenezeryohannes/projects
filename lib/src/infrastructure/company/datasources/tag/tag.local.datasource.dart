import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../appcore/errors/failure.dart';

@lazySingleton
class TagLocalDataSource {
  late SharedPreferences cache;
  static String TAG_KEY = "TAG_KEY";
  TagLocalDataSource({required this.cache});

  Future<bool>? saveTags(int? page, List<TagEntity>? tags) async {
    if (page != null && page > 1) return false;
    return await cache.setString(TAG_KEY, json.encode(tags));
  }

  Future<List<TagEntity>> loagTags() async {
    final data = cache.getString(TAG_KEY);
    if (data == null) throw CacheFailure(message: "No Cache!");
    return parseTagsFromJson(json.decode(data));
  }

  Future<List<TagEntity>> parseTagsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<TagEntity>.from(l.map((model) => TagEntity.fromJson(model)));
  }
}
