import 'package:flutter/material.dart';
import 'package:food_delivery/src/utility/BaseURL.dart';

Widget BuildListKeranjang(
    {BuildContext context,
    AsyncSnapshot<List> snapshot,
    VoidCallback getHasData}) {
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

        return Padding(
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
                  height: 10.0,
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
                          Icon(
                            Icons.remove_circle,
                            color: Colors.red[600],
                            size: 24.0,
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
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}
