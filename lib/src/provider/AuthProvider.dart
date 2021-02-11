import 'dart:convert';

import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:http/http.dart' show Client;

class AuthProvider {
  Client client = Client();

  Future<dynamic> getValidateEmail(String email) async {
    var uri = Uri.parse(BaseURL.urlGetValidateEmail);

    uri = uri.replace(queryParameters: <String, String>{
      'email': email,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'aplication/json',
    });

    return jsonDecode(res.body);
  }

  Future<dynamic> login(String email, String password) async {
    final res = await client.post(BaseURL.urlLogin, headers: {
      'Accept': 'aplication/json',
    }, body: {
      'email': email,
      'password': password,
    });

    return jsonDecode(res.body);
  }

  Future<dynamic> register(
      String nama, String no_telp, String email, String password) async {
    final res = await client.post(BaseURL.urlRegister, headers: {
      'Accept': 'aplication/json',
    }, body: {
      'nama': nama,
      'no_telp': no_telp,
      'email': email,
      'password': password,
    });

    return jsonDecode(res.body);
  }
}
