import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static saveToken(String? token) async {
    await _prefs.setString('loginToken', token ?? "");
  }

  static String getToken() {
    return _prefs.getString('loginToken') ?? "";
  }

  static Future<bool> logOut() async {
    bool logout = await _prefs.clear();
    return logout;
  }
}
