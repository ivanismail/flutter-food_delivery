import 'package:food_delivery/src/model/AddressModel.dart';
import 'package:food_delivery/src/model/TransaksiModel.dart';
import 'package:food_delivery/src/provider/TransaksiProvider.dart';
import 'package:food_delivery/src/repository/TransaksiRepo.dart';
import 'package:rxdart/rxdart.dart';

class TransaksiBloc {
  final _repo = TransaksiRepo();

  final _getTransaksi = PublishSubject<List<TransaksiModel>>();
  Stream<List<TransaksiModel>> get countTransaksi => _getTransaksi.stream;

  final _getAllAddress = PublishSubject<List<AddressModel>>();
  Observable<List<AddressModel>> get countAddress => _getAllAddress.stream;

  getTotalBayar(String id_pelanggan) {
    return _repo.getTotalBayar(id_pelanggan);
  }

  postTransaction(Map<String, String> data) {
    return _repo.postTransaction(data);
  }

  getAddressMap(String at) async {
    List<AddressModel> addressMap = await _repo.getAddressMap(at);
    _getAllAddress.sink.add(addressMap);
  }

  disposee() async {
    await _getAllAddress.drain();
    _getAllAddress.close();
  }

  // getAddressMap(Map<String, String> datalg) {
  //   return _repo.getAddressMap(datalg);
  // }

  getTransaksi(String id_pelanggan) async {
    List<TransaksiModel> trf = await _repo.getTransaksi(id_pelanggan);
    _getTransaksi.sink.add(trf);
  }

  dispose() async {
    await _getTransaksi.drain();
    _getTransaksi.close();
  }
}

final transaksiBloc = TransaksiBloc();
