import 'package:flutter/material.dart';

class Transaksi extends StatefulWidget {
  Transaksi({Key key}) : super(key: key);

  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Transaksi'),
      ),
    );
  }
}
