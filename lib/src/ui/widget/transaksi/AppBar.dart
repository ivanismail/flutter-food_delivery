import 'package:flutter/material.dart';

AppBar buildAppBarTrans(BuildContext context) {
  return AppBar(
    textTheme: TextTheme(),
    backgroundColor: Colors.white,
    brightness: Brightness.dark,
    elevation: 1,
    title: Text(
      'Transaksi',
      style: TextStyle(
        fontFamily: 'Varela',
        fontSize: 24,
        color: Colors.grey[600],
      ),
      textAlign: TextAlign.start,
    ),
  );
}
