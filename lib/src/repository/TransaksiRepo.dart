import 'package:food_delivery/src/provider/TransaksiProvider.dart';

class TransaksiRepo {
  final _provider = TransaksiProvider();

  Future getTotalBayar(String id_pelanggan) {
    return _provider.getTotalBayar(id_pelanggan);
  }
}
