import 'dart:convert';

import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:http/http.dart' show Client;

class KeranjangProvider {
  Client client = Client();

  Future<dynamic> tambahKeranjang(String nama_produk, String harga, String qty,
      String gambar, String id_pelanggan) async {
    final res = await client.post(BaseURL.urlAddCart, headers: {
      'Accept': 'aplication/json',
    }, body: {
      'nama_produk': nama_produk,
      'harga': harga,
      'qty': qty,
      'gambar': gambar,
      'id_pelanggan': id_pelanggan,
    });

    return jsonDecode(res.body);
  }
}
