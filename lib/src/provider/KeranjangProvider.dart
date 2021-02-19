import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_delivery/src/model/KeranjangModel.dart';
import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:http/http.dart' show Client;

class KeranjangProvider {
  Client client = Client();

  Future<List<KeranjangModel>> getKeranjang(String id_pelanggan) async {
    var uri = Uri.parse(BaseURL.urlGetCart);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'application/json',
    });

    if (res.statusCode == 200) {
      return compute(keranjangFromJson, res.body);
    } else {
      return [];
    }
  }

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

  Future<dynamic> ubahQtyKeranjang(Map<String, String> data) async {
    final res = await client.post(BaseURL.urlupdateQtyCart, headers: {
      'Accept': 'aplication/json',
    }, body: {
      'id': data['id'],
      'qty': data['qty'],
    });

    return jsonDecode(res.body);
  }

  Future<dynamic> deleteItemCart(String id) async {
    final res = await client.post(BaseURL.urldeleteItemCart, headers: {
      'Accept': 'aplication/json',
    }, body: {
      'id': id,
    });

    return jsonDecode(res.body);
  }

  Future<dynamic> getTotalItem(String id_pelanggan) async {
    var uri = Uri.parse(BaseURL.urlGetTotalItem);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });
    final res = await client.get(uri, headers: {
      'Accept': 'aplication/json',
    });

    return jsonDecode(res.body);
  }
}
