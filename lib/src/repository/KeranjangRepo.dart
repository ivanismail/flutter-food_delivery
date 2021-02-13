import 'package:food_delivery/src/provider/KeranjangProvider.dart';

class KeranjangRepo {
  final _cartProvider = KeranjangProvider();

  Future tambahKeranjang(Map<String, String> data) {
    return _cartProvider.tambahKeranjang(data);
  }
}
