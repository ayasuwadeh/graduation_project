import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/models/gallary.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project/api/api_util.dart';
class MapSample extends StatefulWidget {
  final Gallery gallery;

  const MapSample({Key key, this.gallery}) : super(key: key);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Position position;
  Set<Marker> markers = {};
  Marker startMarker;

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

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.gallery.location.lat, widget.gallery.location.lan),
              zoom: 15,
            ),
          ),
          Positioned(
            top:size.height*0.9 ,
            left: size.width*0.54 ,
            child:ElevatedButton(
              onPressed: () {
                ApiUtil.DIRECTION(position.latitude.toString(),
                    position.longitude.toString(),
                    widget.gallery.location.lat.toString(),
                    widget.gallery.location.lan.toString());

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
          )
        ],
      ),
    );
  }
  void _setInitialMarker() {
    startMarker = Marker(
      markerId: MarkerId('POI'),
      position: LatLng(
          widget.gallery.location.lat, widget.gallery.location.lan),
      infoWindow: InfoWindow(
        title: widget.gallery.name,
        snippet: 'provided by cockatoo',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    markers.add(startMarker);
  }
  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';


}
