import 'package:flutter/material.dart';

class Alamat extends StatelessWidget {
  String alamat;
  VoidCallback getAddress;

  Alamat({this.alamat, this.getAddress});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 15.0,
        right: 15.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 13.0,
                    ),
                    text: alamat,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
