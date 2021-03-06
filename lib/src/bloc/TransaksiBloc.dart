import 'package:food_delivery/src/repository/TransaksiRepo.dart';

class TransaksiBloc {
  final _repo = TransaksiRepo();

  getTotalBayar(String id_pelanggan) {
    return _repo.getTotalBayar(id_pelanggan);
  }

  postTransaction(Map<String, String> data) {
    return _repo.postTransaction(data);
  }

  getAddressMap(Map<String, String> datalg) {
    return _repo.getAddressMap(datalg);
  }
}

final transaksiBloc = TransaksiBloc();
