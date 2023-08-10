import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/infrastructure/company/dto/company.dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../appcore/errors/failure.dart';

@lazySingleton
class ChatLocalDataSource {
  late SharedPreferences cache;
  static String CHAT_KEY = "CHAT_KEY";
  static String CHAT_COMPANY_KEY = "CHAT_COMPANY_KEY";
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

  Future<bool>? saveChatCompanies(List<CompanyEntity>? chats) async {
    if (chats == null || chats.isEmpty) {
      return true;
    }
    for (int i = 0; i < chats.length; i++) {
      await cache.setString(
          '${CHAT_COMPANY_KEY}_${chats[i].id}', json.encode(chats[i]));
    }
    return true;
  }

  Future<List<CompanyEntity>> loadChatCompanies(List<int> ids) async {
    if (ids.isEmpty) return [];
    List<CompanyEntity> results = [];
    for (int i = 0; i < ids.length; i++) {
      final data = cache.getString('${CHAT_COMPANY_KEY}_${ids[i]}');
      if (data == null) throw CacheFailure(message: "No Cache!");
      results.add(CompanyEntity.fromJson(json.decode(data)));
    }
    return results;
  }

  Future<List<ChatEntity>> parseFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<ChatEntity>.from(l.map((model) => ChatEntity.fromJson(model)));
  }

  Future<List<CompanyEntity>> parseCompaniesFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<CompanyEntity>.from(
        l.map((model) => CompanyEntity.fromJson(model)));
  }
}
