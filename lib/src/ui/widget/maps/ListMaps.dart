import 'package:food_delivery/src/bloc/TransaksiBloc.dart';

class ListMaps {
  String at;

  void initState() {
    transaksiBloc.getAddressMap(at);
    initState();
  }

  void dispose() {
    transaksiBloc.dispose();
    dispose();
  }
}
