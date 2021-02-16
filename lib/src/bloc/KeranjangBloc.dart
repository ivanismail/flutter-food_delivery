import 'package:food_delivery/src/model/KeranjangModel.dart';
import 'package:food_delivery/src/repository/KeranjangRepo.dart';
import 'package:rxdart/rxdart.dart';

class KeranjangBloc {
  final _cartRepo = KeranjangRepo();

  final _getAllKeranjang = PublishSubject<List<KeranjangModel>>();
  Observable<List<KeranjangModel>> get countKeranjang =>
      _getAllKeranjang.stream;

  getKeranjang(String id_pelanggan) async {
    List<KeranjangModel> keranjang = await _cartRepo.getKeranjang(id_pelanggan);
    _getAllKeranjang.sink.add(keranjang);
  }

  addCart(String nama_produk, String harga, String qty, String gambar,
      String id_pelanggan) {
    return _cartRepo.tambahKeranjang(
        nama_produk, harga, qty, gambar, id_pelanggan);
  }

  udpateQtyCart(String id, String qty) {
    return _cartRepo.ubahQtyKeranjang(id, qty);
  }

  getTotalItem(String id_pelanggan) {
    return _cartRepo.getTotalItem(id_pelanggan);
  }

  dispose() async {
    await _getAllKeranjang.drain();
    _getAllKeranjang.close();
  }
}

final cartBloc = KeranjangBloc();
