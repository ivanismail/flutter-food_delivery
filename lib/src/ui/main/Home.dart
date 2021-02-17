import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/KeranjangBloc.dart';
import 'package:food_delivery/src/bloc/ProdukBloc.dart';
import 'package:food_delivery/src/ui/main/Keranjang.dart';
import 'package:food_delivery/src/ui/main/Produk.dart';
import 'package:food_delivery/src/utility/SessionManager.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String kategori = 'all';
  String id_pelanggan;
  bool isLogin;
  VoidCallback getTotalItem;

  int totalItem = 0;
  String totalString;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 7);
    _getLogin();

    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    produkBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    produkBloc.getProduk(kategori);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        textTheme: TextTheme(),
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        elevation: 0.0,
        title: Text(
          'Food Delivery',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Varela',
          ),
          textAlign: TextAlign.start,
        ),
        actions: [
          Badge(
            badgeContent: Text(
              '$totalItem',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8.0,
              ),
            ),
            showBadge: totalItem == 0 ? false : true,
            position: BadgePosition.topEnd(top: 5, end: 4),
            badgeColor: Colors.red,
            toAnimate: true,
            animationDuration: Duration(milliseconds: 200),
            animationType: BadgeAnimationType.scale,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Keranjang(
                        id_pelanggan: id_pelanggan,
                        getTotalItem: _getTotalItem,
                      ),
                    ));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.lightBlue[800],
          isScrollable: true,
          labelPadding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          unselectedLabelColor: Color(0xFFCDCDCD),
          onTap: _getTabs,
          tabs: [
            Tab(
              child: Text(
                'Semua',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Paket',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Nasi',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Bakso',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Sayuran',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Kue',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Minuman',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Produk(
            kategori: 'all',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
            getTotalItem: _getTotalItem,
          ),
          Produk(
            kategori: 'paket',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
            getTotalItem: _getTotalItem,
          ),
          Produk(
            kategori: 'nasi',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
            getTotalItem: _getTotalItem,
          ),
          Produk(
            kategori: 'bakso',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
            getTotalItem: _getTotalItem,
          ),
          Produk(
            kategori: 'sayuran',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
            getTotalItem: _getTotalItem,
          ),
          Produk(
            kategori: 'kue',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
            getTotalItem: _getTotalItem,
          ),
          Produk(
            kategori: 'minuman',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
            getTotalItem: _getTotalItem,
          ),
        ],
      ),
    );
  }

  _getTabs(int value) {
    if (value == 0) {
      setState(() {
        kategori = 'all';
      });
    } else if (value == 1) {
      setState(() {
        kategori = 'paket';
      });
    } else if (value == 2) {
      setState(() {
        kategori = 'nasi';
      });
    } else if (value == 3) {
      setState(() {
        kategori = 'bakso';
      });
    } else if (value == 4) {
      setState(() {
        kategori = 'sayuran';
      });
    } else if (value == 5) {
      setState(() {
        kategori = 'kue';
      });
    } else if (value == 6) {
      setState(() {
        kategori = 'minuman';
      });
    }
  }

  _getLogin() async {
    bool _isLogin = await SessionManager().getIsLogin();
    String _id = await SessionManager().getIdPelanggan();

    setState(() {
      isLogin = _isLogin;
      id_pelanggan = _id;
    });
    _getTotalItem();
  }

  _getTotalItem() async {
    setState(() {
      totalItem = 0;
    });

    final res = await cartBloc.getTotalItem(id_pelanggan);

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      print(message);

      setState(() {
        totalString = res['data']['totalItem'];
        totalItem = int.parse(totalString);
      });
    } else {
      print(message);
    }
  }
}
