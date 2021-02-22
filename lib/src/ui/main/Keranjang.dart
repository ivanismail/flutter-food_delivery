import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/KeranjangBloc.dart';
import 'package:food_delivery/src/model/KeranjangModel.dart';
import 'package:food_delivery/src/ui/main/Pemesanan.dart';
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
              ),
              Positioned(
                bottom: 0.1,
                left: 0.1,
                right: 0.1,
                child: Container(
                  height: 60.0,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.0,
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Material(
                    elevation: 0.1,
                    color: Colors.lightBlue[800],
                    borderRadius: BorderRadius.circular(5.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        width: 160.0,
                        child: Center(
                          child: Text(
                            'Lanjutkan pemesanan'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Pemesanan(
                                      id_pelanggan: widget.id_pelanggan,
                                    )
                            ));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getHasData() async {}
}
