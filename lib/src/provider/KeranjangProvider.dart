import 'dart:convert';

import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:http/http.dart' show Client;

class KeranjangProvider {
  Client client = Client();

  Future<dynamic> tambahKeranjang(Map<String, String> data) async {
    final res = await client.post(BaseURL.urlAddCart, headers: {
      'Accept': 'aplication/json',
    }, body: {
      'nama_produk': data['nama_produk'],
      'harga': data['harga'],
      'qty': data['qty'],
      'gambar': data['gambar'],
      'id_pelanggan': data['id_pelanggan'],
    });

    return jsonDecode(res.body);
  }
}
