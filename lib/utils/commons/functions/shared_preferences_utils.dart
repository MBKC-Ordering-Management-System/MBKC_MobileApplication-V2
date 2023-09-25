import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/token_model.dart';

class SharedPreferencesUtils {
  // get token
  static Future<TokenModel?> getInstance(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(key) ?? '';
    if (token.isNotEmpty) {
      return TokenModel.fromJson(token);
    }
    return null;
  }

  // set token
  static Future<void> setInstance(TokenModel token, String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.setString(key, token.toJson());
  }
}
