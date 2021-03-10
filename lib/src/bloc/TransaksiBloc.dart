import 'package:food_delivery/src/model/AddressModel.dart';
import 'package:food_delivery/src/repository/TransaksiRepo.dart';
import 'package:rxdart/rxdart.dart';

class TransaksiBloc {
  final _repo = TransaksiRepo();

  getTotalBayar(String id_pelanggan) {
    return _repo.getTotalBayar(id_pelanggan);
  }

  postTransaction(Map<String, String> data) {
    return _repo.postTransaction(data);
  }

  final _getAllAddress = PublishSubject<List<AddressModel>>();
  Observable<List<AddressModel>> get countAddress => _getAllAddress.stream;

  getAddressMap(String at) async {
    List<AddressModel> addressMap = await _repo.getAddressMap(at);
    _getAllAddress.sink.add(addressMap);
  }

  dispose() async {
    await _getAllAddress.drain();
    _getAllAddress.close();
  }

  // getAddressMap(Map<String, String> datalg) {
  //   return _repo.getAddressMap(datalg);
  // }
}

final transaksiBloc = TransaksiBloc();
