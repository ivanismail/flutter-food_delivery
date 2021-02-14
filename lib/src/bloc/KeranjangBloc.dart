import 'package:food_delivery/src/repository/KeranjangRepo.dart';

class KeranjangBloc {
  final _cartRepo = KeranjangRepo();

  addCart(String nama_produk, String harga, String qty, String gambar,
      String id_pelanggan) {
    return _cartRepo.tambahKeranjang(
        nama_produk, harga, qty, gambar, id_pelanggan);
  }

  getTotalItem(String id_pelanggan) {
    return _cartRepo.getTotalItem(id_pelanggan);
  }
}

final cartBloc = KeranjangBloc();
