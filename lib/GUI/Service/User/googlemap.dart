import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.9040701, 108.3805108),
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 300.8334901395799,
      target: LatLng(24.837006, 55.406802),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(

        mapType: MapType.satellite,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          mapController.animateCamera(CameraUpdate.newLatLngBounds(LatLngBounds(
            southwest:LatLng(48.8589507, 2.2770205),
            northeast: LatLng(50.8550625, 4.3053506),
          ),
              48.0));
        },
        myLocationEnabled: true,

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Heart Lake Dubai!'),
        icon: Icon(Icons.map),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}