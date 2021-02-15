import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/KeranjangBloc.dart';
import 'package:food_delivery/src/model/KeranjangModel.dart';
import 'package:food_delivery/src/ui/widget/detail/AppBarDetail.dart';
import 'package:food_delivery/src/ui/widget/keranjang/AppBarKeranjang.dart';
import 'package:food_delivery/src/ui/widget/keranjang/BuildListKeranjang.dart';

class Keranjang extends StatefulWidget {
  String id_pelanggan;
  VoidCallback getTotalItem;

  Keranjang({
    this.id_pelanggan,
    this.getTotalItem,
  });

  @override
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  int totalBayar;
  int totalOngkir;
  bool isHasData = false;

  @override
  void initState() {
    super.initState();
    cartBloc.getKeranjang(widget.id_pelanggan);
  }

  @override
  void dispose() {
    super.dispose();

    cartBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        widget.getTotalItem();

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBarKeranjang(
          context: context,
          getTotalItem: widget.getTotalItem,
          id_pelanggan: widget.id_pelanggan,
        ),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                  stream: cartBloc.countKeranjang,
                  builder:
                      (context, AsyncSnapshot<List<KeranjangModel>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty) {
                        return Center(
                          child: Text('Keranjang kosong'),
                        );
                      } else {
                        return BuildListKeranjang(
                          context: context,
                          snapshot: snapshot,
                          getHasData: _getHasData,
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getHasData() async {}
}
