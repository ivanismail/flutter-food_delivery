import 'package:flutter/material.dart';
import 'package:food_delivery/src/model/TransaksiModel.dart';
import 'package:food_delivery/src/ui/main/DetailTransaksi.dart';

Widget TransaksiItem(
    {BuildContext context, AsyncSnapshot<List<TransaksiModel>> snapshot}) {
  return Container(
    margin: EdgeInsets.only(bottom: 60.0),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (context, i) {
        final data = snapshot.data[i];

        Color statusColor;
        IconData statusIcon;

        if (data.status == '0') {
          statusColor = Colors.red;
          statusIcon = Icons.cancel;
        } else if (data.status == '1') {
          statusColor = Colors.orange;
          statusIcon = Icons.assignment_late;
        } else if (data.status == '2') {
          statusColor = Colors.blue;
          statusIcon = Icons.sync;
        } else if (data.status == '3') {
          statusColor = Colors.lightBlueAccent;
          statusIcon = Icons.motorcycle;
        } else {
          statusColor = Colors.green;
          statusIcon = Icons.assignment_turned_in;
        }

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailTransaksi(
                          kd_pemesanan: data.kd_pemesanan,
                          tgl_pesan: data.tgl_pesan,
                          total_bayar: data.total_bayar,
                          alamat_kirim: data.alamat_kirim,
                          status: data.status,
                          noteCancel: data.noteCancel,
                          note: data.note,
                          payment: data.payment,
                          ongkir: data.ongkir,
                          id_pelanggan: data.id_pelanggan,
                        )));
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 5.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 80.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                      ),
                    ),
                    child: Icon(
                      statusIcon,
                      color: statusColor,
                      size: 32.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ID BOOKING FD-${data.kd_pemesanan}',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 14.0,
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '${data.tgl_pesan}',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 12.0,
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 14.0,
                              color: Colors.lightBlue[800],
                              fontWeight: FontWeight.bold,
                            ),
                            text: '${data.alamat_kirim}',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
