import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:graduation_project/models/hotel.dart';
import 'package:graduation_project/models/item_details.dart';
import 'map_card.dart';
class MapScreen extends StatefulWidget {
  final  item;
  final ItemDetails details;

  const MapScreen({Key key, this.item, this.details}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Position initialPosition = new Position(
      latitude: 32.227522, longitude: 35.223183);

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};

  Marker startMarker;

  @override
  void initState() {
    _setInitialMarker();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("loooooooool"+widget.details.rating.toString());
    print("loooooooool"+widget.details.image);
    print("loooooooool"+widget.details.url);
    print("loooooooool"+widget.details.lat.toString());
    print("loooooooool"+widget.details.lan.toString());


    return Scaffold(
      // ignore: missing_required_param
      body: Center(
        child: Stack(
          children: [
          GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
           markers: markers != null ? Set<Marker>.from(markers) : null,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.details.lat,
                  widget.details.lan),
              zoom: 16),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

        Positioned(
          top: 525,
          left: -7,
            child: MapCard(hotel: widget.item,
            hotelDetails: widget.details,))
        ],
      ),
    ),

    );
  }
  void _setInitialMarker() {
    print("hhhhhhhhhhhh");
    // Start Location Marker
    startMarker = Marker(
      markerId: MarkerId('POI'),
      position: LatLng(
          widget.details.lat, widget.details.lan),
      infoWindow: InfoWindow(
        title: widget.item.name,
        snippet: 'provided by cockatoo',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    markers.add(startMarker);
  }
}
