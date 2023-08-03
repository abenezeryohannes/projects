import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../appcore/errors/failure.dart';

@lazySingleton
class ChatLocalDataSource {
  late SharedPreferences cache;
  static String CHAT_KEY = "CHAT_KEY";
  ChatLocalDataSource({required this.cache});

  Future<bool>? saveChat(bool rewrite, List<ChatEntity>? chats) async {
    if (chats == null) {
      return true;
    } else if (rewrite) {
      return await cache.setString(CHAT_KEY, json.encode(chats));
    } else {
      final allChats = await loadChats();
      allChats.insertAll(0, chats);
      return await cache.setString(CHAT_KEY, json.encode(allChats));
    }
  }

  Future<List<ChatEntity>> loadChats() async {
    final data = cache.getString(CHAT_KEY);
    if (data == null) throw CacheFailure(message: "No Cache!");
    return parseFromJson(json.decode(data));
  }

  Future<List<ChatEntity>> parseFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<ChatEntity>.from(l.map((model) => ChatEntity.fromJson(model)));
  }
}
