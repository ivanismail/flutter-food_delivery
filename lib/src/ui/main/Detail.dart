import 'package:flutter/material.dart';
import 'package:food_delivery/src/ui/widget/detail/AddCartButton.dart';
import 'package:food_delivery/src/ui/widget/detail/AppBarDetail.dart';
import 'package:food_delivery/src/ui/widget/detail/CartCounter.dart';
import 'package:food_delivery/src/ui/widget/detail/Deskripsi.dart';
import 'package:food_delivery/src/ui/widget/detail/Favorite.dart';
import 'package:food_delivery/src/ui/widget/detail/HeaderDetail.dart';

class Detail extends StatefulWidget {
  String nama_produk;
  String kategori;
  String deskripsi;
  String gambar;
  int harga;

  Detail({
    this.nama_produk,
    this.kategori,
    this.deskripsi,
    this.gambar,
    this.harga,
  });

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int numQty = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.lightBlue[800],
      appBar: AppBarDetail(context),
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
                                padding:
                                EdgeInsets.symmetric(horizontal: 20.0 / 2),
                                child: Text(
                                  numQty.toString().padLeft(2, "0"),
                                  style: Theme.of(context).textTheme.headline6,
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
                      AddCartButton(),
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
    );
  }
}
