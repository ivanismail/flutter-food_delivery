import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/TransaksiBloc.dart';
import 'package:food_delivery/src/model/AddressModel.dart';
import 'package:food_delivery/src/ui/widget/maps/AppBarMaps.dart';
import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:food_delivery/src/utility/FadeAnimation.dart';
import 'package:food_delivery/src/utility/SessionManager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';

class Maps extends StatefulWidget {
  VoidCallback getAddress;

  List<dynamic> _nearbyPlaces = [];

  Maps({this.getAddress});
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng;

  final Set<Marker> _markers = {};

  List<Placemark> placemark;

  double lat;
  double long;
  String _alamat;
  String at, s1, s2, output, apiKey;
  bool isSave;
  bool isSet;

  @override
  void initState() {
    super.initState();
    isSave = false;
    isSet = false;

    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    transaksiBloc.getAddressMap(at);
    return Scaffold(
        appBar: AppBarMaps(context: context),
        body: latLng == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: latLng, zoom: 15.0),
                      markers: _markers,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      onTap: (position) {
                        setState(() {
                          isSet = true;
                          _markers.clear();

                          lat = position.latitude;
                          long = position.longitude;

                          _markers.add(
                            Marker(
                                markerId: MarkerId(
                                    "${position.latitude}, ${position.longitude}"),
                                icon: BitmapDescriptor.defaultMarker,
                                position: position,
                                onTap: () {
                                  setState(() {
                                    isSet = true;
                                  });
                                }),
                          );
                        });
                      },
                    ),
                  ),
                  if (isSave)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (isSet)
                    Positioned(
                      bottom: 10.0,
                      left: 0.1,
                      right: 0.1,
                      child: FadeAnimation(
                          0.5,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    elevation: 1.0,
                                    color: Colors.blue[800],
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(5.0),
                                      onTap: () {
                                        _setAlamat();
                                      },
                                      child: Container(
                                        width: 100.0,
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            'PILIH LOKASI INI',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Material(
                                  elevation: 1.0,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5.0),
                                    onTap: () {
                                      isSet = false;
                                    },
                                    child: Container(
                                      width: 40.0,
                                      padding: EdgeInsets.all(6.0),
                                      child: Center(
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )
                ],
              ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _getLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        print('denied');
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
        print('restricted');
        break;
      case GeolocationStatus.unknown:
        print('unknown');
        break;
      case GeolocationStatus.granted:
        await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((Position _position) {
          if (_position != null) {
            if (mounted) {
              setState(() {
                latLng = LatLng(
                  _position.latitude,
                  _position.longitude,
                );
              });
            }
          }
        });
        break;
    }
  }

  // _setAlamat() async {
  //   setState(() {
  //     isSave = true;
  //   });
  //
  //   try {
  //     HereMaps(apiKey: BaseURL.apiKey)
  //         .exploreNearbyPlaces(lat: lat, lon: long, offset: 10)
  //         .then((response) {
  //        setState(() {
  //          _alamat=(response['result']['items']);
  //        });
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   print(_alamat);
  //
  //   SessionManager().setSessionAddress(lat, long, _alamat);
  //
  //   setState(() {
  //     isSave = false;
  //   });
  //
  //   Navigator.pop(context);
  //   widget.getAddress();
  // }

  // _setAlamat() async {
  //   setState(() {
  //     isSave = true;
  //   });
  //
  //   try {
  //     placemark = await Geolocator().placemarkFromCoordinates(lat, long);
  //
  //     if (mounted) {
  //       setState(() {
  //         _alamat = placemark[0].name.toString() +
  //             ", " +
  //             placemark[0].subLocality.toString() +
  //             ", " +
  //             placemark[0].locality.toString() +
  //             ", " +
  //             placemark[0].administrativeArea.toString() +
  //             ", " +
  //             placemark[0].country.toString();
  //       });
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   print(_alamat);
  //
  //   SessionManager().setSessionAddress(lat, long, _alamat);
  //
  //   setState(() {
  //     isSave = false;
  //   });
  //
  //   Navigator.pop(context);
  //   widget.getAddress();
  // }

  _setAlamat() async {
    setState(() {
      isSave = true;
    });

    try {
      //apiKey = "7_KPQb0dn8oOrxdDqtwfZSypnGze5kFMZFxpv6DThPY";

      var s1 = double.parse(lat.toString());
      var s2 = double.parse(long.toString());
      at = s1.toString() + ',' + s2.toString();

      User.getUsers("-6.272202,106.912216,15").then((users) {
        output = "";
        for (int i = 0; i < users.length; i++)
          _alamat = output + " " + users[i].title + " ";
        setState(() {});
      });

      // } else {
      //   print(message);
      // }
    } catch (e) {
      print(e.toString());
    }
    //String tags;
    print(_alamat);

    SessionManager().setSessionAddress(lat, long, _alamat);

    setState(() {
      isSave = false;
    });

    Navigator.pop(context);
    widget.getAddress();
  }
}
