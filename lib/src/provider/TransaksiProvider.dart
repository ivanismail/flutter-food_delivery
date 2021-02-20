import 'dart:convert';

import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:http/http.dart' show Client;

class TransaksiProvider {
  Client client = Client();

  Future<dynamic> getTotalBayarl(String id_pelanggan) async {
    var uri = Uri.parse(BaseURL.urlGetTotalbayar);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'aplication/json',
    });

    return jsonDecode(res.body);
  }
}
