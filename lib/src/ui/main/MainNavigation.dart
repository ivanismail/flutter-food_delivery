import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:food_delivery/src/ui/main/Home.dart';
import 'package:food_delivery/src/ui/main/Transaksi.dart';
import 'package:food_delivery/src/ui/main/Akun.dart';
import 'package:food_delivery/src/utility/SessionManager.dart';
import 'package:food_delivery/src/ui/main/Login.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex;
  var page;

  bool isLogin;

  @override
  void initState() {
    _currentIndex = 0;
    page = Home();

    _getLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(isLogin);
    return Scaffold(
      body: page,
      bottomNavigationBar: bmnav.BottomNav(
        color: Colors.white,
        labelStyle: bmnav.LabelStyle(
            visible: true,
            showOnSelect: false,
            onSelectTextStyle: TextStyle(
              color: Colors.grey,
              height: 1.8,
            ),
            textStyle: TextStyle(
              color: Colors.grey,
              height: 1.8,
            )),
        iconStyle: bmnav.IconStyle(
          color: Colors.grey[400],
          onSelectSize: 22.0,
          size: 22.0,
        ),
        elevation: 6.0,
        onTap: (i) {
          _currentIndex = i;
          _currentPage(i);
        },
        index: _currentIndex,
        items: [
          bmnav.BottomNavItem(
            Icons.home,
            label: 'Home',
          ),
          bmnav.BottomNavItem(
            Icons.assignment,
            label: 'Transaksi',
          ),
          bmnav.BottomNavItem(
            Icons.person,
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  void _currentPage(int i) {
    if (i == 0) {
      setState(() {
        page = Home();
      });
    } else if (i == 1) {
      if (isLogin) {
        setState(() {
          page = Transaksi();
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
            (route) => false);
      }
    } else {
      if (isLogin) {
        setState(() {
          page = Akun();
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
            (route) => false);
      }
    }
  }

  _getLogin() async {
    bool _isLogin = await SessionManager().getIsLogin();

    setState(() {
      isLogin = _isLogin;
    });
  }
}
