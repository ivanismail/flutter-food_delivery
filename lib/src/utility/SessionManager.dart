import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  setSession(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('is_login', true);
    preferences.setString("id", id);
  }

  Future<bool> getIsLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("is_login") ?? false;
  }

  Future<String> getIdPelanggan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('id') ?? '0';
  }

  removeSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("is_login");
    preferences.remove("id");
  }
}
