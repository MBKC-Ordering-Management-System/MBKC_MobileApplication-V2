import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user_model.dart';

class SharedPreferencesUtils {
  // get token
  static Future<UserModel?> getInstance(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(key) ?? '';
    if (user.isNotEmpty) {
      return UserModel.fromJson(user);
    }
    return null;
  }

  // set token
  static Future<void> setInstance(UserModel user, String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.setString(key, user.toJson());
  }

  // set token
  static Future<void> clearInstance(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // get user permission
  static Future<bool?> getUserPermission(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final permission = prefs.getBool(key);
    return permission;
  }

  // set user permission
  static Future<void> setUserPermission(bool value, String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.setBool(key, value);
  }
}
