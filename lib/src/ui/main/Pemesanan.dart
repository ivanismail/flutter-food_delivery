import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/TransaksiBloc.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/Alamat.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/AppBar.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/Bayar.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/Catatan.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/ListPesanan.dart';
import 'package:food_delivery/src/utility/SessionManager.dart';
import 'package:intl/intl.dart';

class Pemesanan extends StatefulWidget {
  String id_pelanggan;

  Pemesanan({
    this.id_pelanggan,
  });
  @override
  _PemesananState createState() => _PemesananState();
}

class _PemesananState extends State<Pemesanan> {
  TextEditingController _noteController = TextEditingController();
  final formatter = NumberFormat("#,###");

  double lat;
  double lng;
  String alamat;
  String payment;
  String totalString;
  String totalString2;
  int isBayar;
  int totalBayar=0;
  int totalOngkir=0;
  bool isKirim = false;
  bool validAlamat;
  bool validPayment;

  @override
  void initState() {
    super.initState();
    _getAddress();
    _getPayment();
    _getTotalBayar();
  }

  @override
  Widget build(BuildContext context) {
    print(totalBayar);
    print(totalOngkir);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 10.0,
                      ),
                      child: Text(
                        'ALAMAT KIRIM',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Alamat(
                      alamat: alamat,
                      getAddress: _getAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 10.0,
                      ),
                      child: Text(
                        'RINGKASAN PESANAN',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ListPesanan(
                      id_pelanggan: widget.id_pelanggan,
                      ongkir: totalOngkir,
                      totalBayar: totalBayar,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 10.0,
                      ),
                      child: Text(
                        'METODE PEMBAYARAN',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Bayar(
                      payment: payment,
                      getPayment: _getPayment,
                    ),
                    Catatan(
                      noteController: _noteController,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getAddress() async {
    Map _result = await SessionManager().getSessionAddress();

    setState(() {
      lat = _result['latitude'];
      lng = _result['longitude'];
      alamat = _result['alamat'];
      validAlamat = _result['hasData'];
    });
  }

  _getPayment() async {
    Map _result = await SessionManager().getSessionPayment();

    setState(() {
      payment = _result['payment'];
      validPayment = _result['hasData'];
    });
  }

  _getTotalBayar() async {
    setState(() {
      totalBayar = 120;
      totalOngkir = 1222;
    });

    final data = await transaksiBloc.getTotalBayar(widget.id_pelanggan);

    bool status = data['status'];
    String message = data['message'];

    if (status) {
      setState(() {
        totalString = data['data']['totalBayar'];
        totalBayar = int.parse(totalString);
        totalString2 = data['data']['totalOngkir'];
        totalOngkir = int.parse(totalString2);
      });
    } else {
      print(message);
    }
  }
}
