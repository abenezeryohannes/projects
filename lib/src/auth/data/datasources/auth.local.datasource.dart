import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AuthLocalDataSource {
  late SharedPreferences sharedPreferences;
  static String USER_KEY = "AUTH_KEY";
  AuthLocalDataSource({required this.sharedPreferences});
}
