import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/user/entities/favorites.entity.dart';

@lazySingleton
class FavoriteLocalDataSource {
  late SharedPreferences cache;
  FavoriteLocalDataSource({required this.cache});
  static String FAVORITE_KEY = "FAVORITE_KEY";

  Future<bool>? saveFavorites(
      int? page, List<FavoriteEntity>? favorites) async {
    if (page != null && page > 1) return false;
    return await cache.setString(FAVORITE_KEY, json.encode(favorites));
  }

  Future<List<FavoriteEntity>> loadFavorites() async {
    final data = cache.getString(FAVORITE_KEY);
    if (data == null) throw CacheFailure(message: "No Cache!");
    return parseFromJson(json.decode(data));
  }

  Future<List<FavoriteEntity>> parseFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<FavoriteEntity>.from(
        l.map((model) => FavoriteEntity.fromJson(model)));
  }
}
