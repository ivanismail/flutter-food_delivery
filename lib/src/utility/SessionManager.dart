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

  //Session Address
  setSessionAddress(double lat, double long, String alamat) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble('latitude', lat);
    preferences.setDouble('longitude', long);
    preferences.setString('alamat', alamat);
    preferences.setBool('hasData', true);
  }

  getSessionAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map data = {
      'latitude': preferences.getDouble('latitude') ?? 0.0,
      'longitude': preferences.getDouble('longitude') ?? 0.0,
      'alamat': preferences.getString('alamat') ?? 'Alamat kirim belum dipilih',
      'hasData': preferences.getBool('hasData') ?? false,
    };

    return data;
  }

  removeSessionAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("latitude");
    preferences.remove("longitude");
    preferences.remove("alamat");
    preferences.remove("hasData");
  }

  //Session Payment
  setSessionPayment(String pay) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('payment', pay);
    preferences.setBool('hasData', true);
  }

  getSessionPayment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map data = {
      'payment':
          preferences.getString('payment') ?? 'Metode pembayaran belum dipilih',
      'hasData': preferences.getBool('hasData') ?? false,
    };

    return data;
  }

  removeSessionPayment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("payment");
    preferences.remove("hasData");
  }
}
