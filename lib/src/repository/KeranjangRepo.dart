import 'package:food_delivery/src/model/KeranjangModel.dart';
import 'package:food_delivery/src/provider/KeranjangProvider.dart';

class KeranjangRepo {
  final _cartProvider = KeranjangProvider();

  Future<List<KeranjangModel>> getKeranjang(String id_pelanggan) {
    return _cartProvider.getKeranjang(id_pelanggan);
  }

  Future tambahKeranjang(String nama_produk, String harga, String qty,
      String gambar, String id_pelanggan) {
    return _cartProvider.tambahKeranjang(
        nama_produk, harga, qty, gambar, id_pelanggan);
  }

  Future ubahQtyKeranjang(Map<String, String> data) {
    return _cartProvider.ubahQtyKeranjang(data);
  }

  Future deleteItemKeranjang(Map<String, String> data) {
    return _cartProvider.deleteItemKeranjang(data);
  }

  Future getTotalItem(String id_pelanggan) {
    return _cartProvider.getTotalItem(id_pelanggan);
  }
}
