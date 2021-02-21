import 'package:food_delivery/src/repository/TransaksiRepo.dart';

class TransaksiBloc {
  final _repo = TransaksiRepo();

  getTotalBayar(String id_pelanggan) {
    return _repo.getTotalBayar(id_pelanggan);
  }
}

final transaksiBloc = TransaksiBloc();
