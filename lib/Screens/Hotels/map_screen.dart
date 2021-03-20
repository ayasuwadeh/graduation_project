import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:graduation_project/models/hotel.dart';
import 'package:graduation_project/models/hotel_details.dart';
import 'map_card.dart';
class MapScreen extends StatefulWidget {
  final Hotel hotel;
  final HotelDetails details;

  const MapScreen({Key key, this.hotel, this.details}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Position initialPosition = new Position(
      latitude: 32.227522, longitude: 35.223183);

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    print("loooooooool"+widget.details.rating.toString());
   // print("loooooooool"+widget.details.image);

    return Scaffold(
      // ignore: missing_required_param
      body: Center(
        child: Stack(
          children: [
          GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          // markers: markers != null ? Set<Marker>.from(markers) : null,
          initialCameraPosition: CameraPosition(
              target: LatLng(initialPosition.latitude,
                  initialPosition.longitude),
              zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

        Positioned(
          top: 525,
          left: -7,
            child: MapCard(hotel: widget.hotel,
            hotelDetails: widget.details,))
        ],
      ),
    ),

    );
  }
  // final planetThumbnail = new Container(
  //        margin: new EdgeInsets.symmetric(
  //    vertical: 16.0
  //       ),
  //    alignment: FractionalOffset.centerLeft,
  //   child: new Image(
  //      image: new AssetImage(planet.image),
  //     height: 92.0,
  //     width: 92.0,
  //     ),
  //   );
}
