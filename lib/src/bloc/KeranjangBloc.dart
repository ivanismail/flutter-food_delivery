import 'package:food_delivery/src/repository/KeranjangRepo.dart';

class KeranjangBloc {
  final _cartRepo = KeranjangRepo();

  addCart(Map<String, String> data) {
    return _cartRepo.tambahKeranjang(data);
  }
}

final cartBloc = KeranjangBloc();
