import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/services/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class RouteMap extends StatefulWidget {


  @override
  _RouteMapState createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  final Position initialPosition=new Position(latitude: 32.227522,longitude:35.223183 ) ;
  final Position finalPosition=new Position(latitude: 32.2226678,longitude:35.2621461 );

  final GeolocatorService geoService = GeolocatorService();
  List<LatLng> points = [];
  List<int> seq = [];
  Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  int _pointId = 0;
  Set<Marker> markers = {};
  Marker startMarker;
  Marker finalMarker;

  StreamSubscription streamSubscription;
  bool startedTracking = false;
  bool emptyRouteNameField = false;

  void initState() {
    _setInitialMarker(initialPosition);
    _setFinalMarker(finalPosition);

    super.initState();
  }

  // void addPointToPolylines(Position position) {
  //   points.add(LatLng(position.latitude, position.longitude));
  //   seq.add(_pointId);
  //   if (_pointId > 0) draw();
  //   _pointId++;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: missing_required_param
      body: Center(
        child: GoogleMap(
          //polylines: Set<Polyline>.of(_mapPolylines.values),
          myLocationEnabled: true,
          mapType: MapType.normal,
          markers: markers != null ? Set<Marker>.from(markers) : null,
          initialCameraPosition: CameraPosition(
              target: LatLng(initialPosition.latitude,
                  initialPosition.longitude),
              zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),

    );
  }


  //
  // Future<void> centerScreen(Position position) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
  //   //// adding positions and sequences
  // }
  //
  // void draw() {
  //   final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
  //   _polylineIdCounter++;
  //   final PolylineId polylineId = PolylineId(polylineIdVal);
  //   LatLng firstPoint = points[_pointId - 1];
  //   LatLng secondPoint = points[_pointId];
  //   final Polyline polyline = Polyline(
  //     polylineId: polylineId,
  //     consumeTapEvents: true,
  //     color: Colors.deepOrange,
  //     width: 3,
  //     points: [firstPoint, secondPoint],
  //   );
  //   setState(() {
  //     _mapPolylines[polylineId] = polyline;
  //   });
  // }

  void _setInitialMarker(Position initialLocation) {
    // Start Location Marker
    startMarker = Marker(
      markerId: MarkerId('start'),
      position: LatLng(
          initialPosition.latitude, initialPosition.longitude),
      infoWindow: InfoWindow(
        title: 'Start',
        snippet: "initial point",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(156),
    );
    markers.add(startMarker);
  }

  void _setFinalMarker(Position initialLocation)  {
    // Start Location Marker
    finalMarker = Marker(
      markerId: MarkerId('dest'),
      position: LatLng(
          finalPosition.latitude, finalPosition.longitude),
      infoWindow: InfoWindow(
        title: 'final',
        snippet: "destination point",
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    markers.add(finalMarker);
  }


}
