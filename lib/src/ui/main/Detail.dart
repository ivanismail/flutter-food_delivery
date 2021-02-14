import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/KeranjangBloc.dart';
import 'package:food_delivery/src/ui/widget/detail/AddCartButton.dart';
import 'package:food_delivery/src/ui/widget/detail/AppBarDetail.dart';
import 'package:food_delivery/src/ui/widget/detail/CartCounter.dart';
import 'package:food_delivery/src/ui/widget/detail/Deskripsi.dart';
import 'package:food_delivery/src/ui/widget/detail/Favorite.dart';
import 'package:food_delivery/src/ui/widget/detail/HeaderDetail.dart';
import 'package:food_delivery/src/utility/SessionManager.dart';
import 'package:food_delivery/src/utility/ShowToast.dart';

class Detail extends StatefulWidget {
  String nama_produk;
  String kategori;
  String deskripsi;
  String gambar;
  int harga;
  String id_pelanggan;
  VoidCallback getTotalItem;

  Detail({
    this.nama_produk,
    this.kategori,
    this.deskripsi,
    this.gambar,
    this.harga,
    this.id_pelanggan,
    this.getTotalItem,
  });

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int numQty = 1;
  int totalItem;
  String id_pelanggan;
  bool isLogin;
  String totalString;

  @override
  void initState() {
    super.initState();
    _getLogin();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        widget.getTotalItem();

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue[800],
        appBar: AppBarDetail(
          context: context,
          totalItem: totalItem,
          id_pelanggan: id_pelanggan,
          isLogin: isLogin,
          getTotalItem: _getTotalItem,
          getTotalItemHome: widget.getTotalItem,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 200.0,
                    ),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: 20.0,
                      right: 20.0,
                    ),
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Deskripsi(
                          deskripsi: widget.deskripsi,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CartCounter(
                                  icon: Icons.remove,
                                  color: Colors.red[600],
                                  press: () {
                                    if (numQty > 1) {
                                      setState(() {
                                        numQty--;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0 / 2),
                                  child: Text(
                                    numQty.toString().padLeft(2, "0"),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                CartCounter(
                                  icon: Icons.add,
                                  color: Colors.green[600],
                                  press: () {
                                    setState(() {
                                      numQty++;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Favorite(),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        AddCartButton(
                          tambahKeranjang: _tambahKeranjang,
                          isLogin: isLogin,
                        ),
                      ],
                    ),
                  ),
                  HeaderDetail(
                    nama_produk: widget.nama_produk,
                    kategori: widget.kategori,
                    harga: widget.harga,
                    gambar: widget.gambar,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
      totalItem = 6;
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

  _tambahKeranjang() async {
    final res = await cartBloc.addCart(
      widget.nama_produk,
      widget.harga.toString(),
      numQty.toString(),
      widget.gambar,
      id_pelanggan,
    );

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      print(message);
      _getTotalItem();
      setState(() {
        numQty = 1;
      });

      ShowToast().showToastSuccess(message);
    } else {
      print(message);

      ShowToast().showToastError(message);
    }
  }
}
