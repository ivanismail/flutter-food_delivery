import 'package:food_delivery/src/provider/KeranjangProvider.dart';

class KeranjangRepo {
  final _cartProvider = KeranjangProvider();

  Future tambahKeranjang(String nama_produk, String harga, String qty,
      String gambar, String id_pelanggan) {
    return _cartProvider.tambahKeranjang(
        nama_produk, harga, qty, gambar, id_pelanggan);
  }

  Future getTotalItem(String id_pelanggan) {
    return _cartProvider.getTotalItem(id_pelanggan);
  }
}