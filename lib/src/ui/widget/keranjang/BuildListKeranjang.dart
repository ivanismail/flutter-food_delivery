import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_delivery/src/bloc/KeranjangBloc.dart';
import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:food_delivery/src/utility/ShowToast.dart';
import 'package:intl/intl.dart';

Widget BuildListKeranjang(
    {BuildContext context,
    AsyncSnapshot<List> snapshot,
    VoidCallback getHasData}) {
  SlidableController slidableController;
  final formatter = NumberFormat("#,###");
  return Container(
    margin: EdgeInsets.only(
      bottom: 60.0,
    ),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int i) {
        final data = snapshot.data[i];

        int numQty = int.parse(data.qty);

        return Slidable(
          controller: slidableController,
          key: Key(data.id),
          actionExtentRatio: 0.25,
          actionPane: SlidableScrollActionPane(),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 5.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0,
                    )
                  ],
                  color: Colors.white),
              child: Row(
                children: [
                  Container(
                    height: 90.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(BaseURL.baseURLImg + data.gambar),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Varela',
                              color: Colors.grey[800],
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            text: data.nama_produk,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (numQty > 1) {
                                  numQty = numQty - 1;
                                  _updateQtyCart(
                                      data.id, numQty, data.id_pelanggan);
                                }
                              },
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.red[600],
                                size: 24.0,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '$numQty',
                              style: TextStyle(
                                  fontFamily: 'Varela',
                                  color: Colors.black,
                                  fontSize: 14.0),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            InkWell(
                              onTap: () {
                                numQty = numQty + 1;
                                _updateQtyCart(
                                    data.id, numQty, data.id_pelanggan);
                              },
                              child: Icon(
                                Icons.add_circle,
                                color: Colors.green[600],
                                size: 24.0,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Rp. ${formatter.format(int.parse(data.harga))}',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                color: Colors.lightBlue[800],
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Total = Rp. ${formatter.format(int.parse(data.harga) * int.parse(data.qty))}',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.lightBlue[800],
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          secondaryActions: [
            IconSlideAction(
              caption: 'Hapus Item',
              iconWidget: Icon(
                Icons.delete_outline,
                color: Colors.red[600],
                size: 28.0,
              ),
              onTap: () => _deleteItemCart(data.id, data.id_pelanggan),

            ),
          ],
        );
      },
    ),
  );
}

_updateQtyCart(String id, int numQty, String id_pelanggan) async {
  Map<String, String> data = {
    'id': id,
    'qty': numQty.toString(),
  };

  final res = await cartBloc.udpateQtyCart(data);

  bool status = res['status'];
  String message = res['message'];

  if (status) {
    cartBloc.getKeranjang(id_pelanggan);

    ShowToast().showToastSuccess(message);
  } else {

    ShowToast().showToastError(message);
  }
}

_deleteItemCart(String id, String id_pelanggan) async {
  final res = await cartBloc.deleteItemCart(id);

  bool status = res['status'];
  String message = res['message'];

  if (status) {
    cartBloc.getKeranjang(id_pelanggan);

    ShowToast().showToastSuccess(message);
  } else {
    ShowToast().showToastError(message);
  }
}
