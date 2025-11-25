import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    prefs.setString("password", password);
  }

  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final u = prefs.getString("username");
    final p = prefs.getString("password");
    return (username == u && password == p);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }
}
