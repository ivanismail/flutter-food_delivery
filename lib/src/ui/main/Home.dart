import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/ProdukBloc.dart';
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
          ),
          Produk(
            kategori: 'paket',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
          ),
          Produk(
            kategori: 'nasi',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
          ),
          Produk(
            kategori: 'bakso',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
          ),
          Produk(
            kategori: 'sayuran',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
          ),
          Produk(
            kategori: 'kue',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
          ),
          Produk(
            kategori: 'minuman',
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
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
  }
}
