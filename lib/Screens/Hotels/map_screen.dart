import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:graduation_project/api/api_util.dart';
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

  Position position;
  void getLocation() async {  position =
  await Geolocator .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position); }

  @override
  void initState() {
    getLocation();
    _setInitialMarker();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
           markers: markers != null ? Set<Marker>.from(markers) : null,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.item.location.lat,
                  widget.item.location.lan),
              zoom: 16),
          // onMapCreated: (GoogleMapController controller) {
          //   _controller.complete(controller);
          // },
        ),
            Positioned(
                top:size.height*0.7,
                left: size.width*0.06 ,
                child:ElevatedButton(
                    onPressed: () {
                      ApiUtil.DIRECTION(position.latitude.toString(),
                          position.longitude.toString(),
                          widget.item.location.lat.toString(),
                          widget.item.location.lan.toString());
                      // _launchURL('https://www.google.com/maps/dir/${position.latitude},${position.longitude}/'
                      //     '${widget.gallery.location.lat},${widget.gallery.location.lan}');

                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)
                            )
                        )
                    ),

                    child:Row(

                      children: [
                        Text("directions  ",style: TextStyle(fontSize: 17),),
                        Icon(Icons.directions),

                      ],
                    )

                )
            ),

        Positioned(
          top: 533,
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
