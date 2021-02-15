import 'package:flutter/material.dart';

AppBar AppBarKeranjang({
  BuildContext context,
  VoidCallback getTotalItem,
  String id_pelanggan,
}) {
  return AppBar(
    backgroundColor: Colors.lightBlue[800],
    elevation: 0.0,
    title: Text(
      'Keranjang',
      style: TextStyle(
        fontFamily: 'Varela',
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.chevron_left,
        size: 32.0,
      ),
    ),
  );
}
