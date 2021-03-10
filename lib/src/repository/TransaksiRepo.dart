import 'package:food_delivery/src/model/AddressModel.dart';
import 'package:food_delivery/src/provider/TransaksiProvider.dart';

class TransaksiRepo {
  final _provider = TransaksiProvider();

  Future getTotalBayar(String id_pelanggan) {
    return _provider.getTotalBayar(id_pelanggan);
  }

  Future postTransaction(Map<String, String> data) {
    return _provider.postTransaction(data);
  }

  // Future<List<AddressModel>> getAddressMap(Map<String, String> datalg) {
  //   return _provider.getAddressMap(datalg);
  // }

  Future<List<AddressModel>> getAddressMap(String at) {
    return _provider.getAddressMap(at);
  }
}
