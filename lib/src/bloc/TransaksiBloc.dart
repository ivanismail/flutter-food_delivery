import 'package:food_delivery/src/repository/TransaksiRepo.dart';

class TransaksiBloc {
  final _repo = TransaksiRepo();

  getTotalBayar(String id_pelanggan) {
    return _repo.getTotalBayar(id_pelanggan);
  }

  postTransaction(Map<String, String> data) {
    return _repo.postTransaction(data);
  }
}

final transaksiBloc = TransaksiBloc();
