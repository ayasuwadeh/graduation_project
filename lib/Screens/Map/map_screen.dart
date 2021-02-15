import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration( size: Size(50,50)), "assets/icons/homeMarker1.png").then((onValue) {

      mapMarker=onValue;
  });}

  void _onMapCreated(GoogleMapController controller) {
    _markers.clear();
    _markers.add(Marker(
        markerId: MarkerId("first"),
        position: LatLng(32.43296265331129, 35.08832357078792),
        icon: mapMarker,
        infoWindow: InfoWindow(title: "nablus",snippet: "hiii")));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(32.43296265331129, 35.08832357078792),
          zoom: 15,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}
