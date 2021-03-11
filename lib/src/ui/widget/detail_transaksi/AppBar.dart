import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.lightBlue[800],
    elevation: 5,
    title: Text(
      'Detail Transaksi Pemesanan',
      style: TextStyle(
        fontFamily: 'Varela',
      ),
    ),
    leading: Icon(
      Icons.chevron_left,
      size: 32.0,
    ),
  );
}
