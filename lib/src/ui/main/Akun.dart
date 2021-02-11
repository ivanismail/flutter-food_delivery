import 'package:flutter/material.dart';
import 'package:food_delivery/src/ui/main/MainNavigation.dart';
import 'package:food_delivery/src/utility/SessionManager.dart';

class Akun extends StatefulWidget {
  Akun({Key key}) : super(key: key);

  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Text('Akun'),
            RaisedButton(
              onPressed: () {
                SessionManager().removeSession();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainNavigation()),
                    (route) => false);
              },
              child: Text('Logout'),
            )
          ],
        ),
      ),
    ));
  }
}
