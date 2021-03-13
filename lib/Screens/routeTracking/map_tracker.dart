import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/services/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';
import 'save_route_dialog.dart';
import 'dart:async';

import '../../gist.dart';

class LiveMap extends StatefulWidget {
  final Position initialPosition;

  const LiveMap({Key key, this.initialPosition}) : super(key: key);
  @override
  _LiveMapState createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {
  final GeolocatorService geoService = GeolocatorService();
  List<LatLng> points = [];
  List<int> seq = [];
  Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  int _pointId = 0;
  Set<Marker> markers = {};
  Marker startMarker;
  StreamSubscription streamSubscription;
  bool startedTracking = false;
  bool emptyRouteNameField = false;


// Destination Location Marker
//   Marker destinationMarker = Marker(
//     markerId: MarkerId('destination'),
//     position: LatLng(
//       destinationCoordinates.latitude,
//       destinationCoordinates.longitude,
//     ),
//     infoWindow: InfoWindow(
//       title: 'Destination',
//       snippet: _destinationAddress,
//     ),
//     icon: BitmapDescriptor.defaultMarker,
//   );

  @override
  void initState() {
    _setInitialMarker(geoService.getInitialLocation());

    super.initState();
  }

  void addPointToPolylines(Position position) {
     points.add(LatLng(position.latitude, position.longitude));
    seq.add(_pointId);
    if (_pointId > 0) draw();
    _pointId++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: missing_required_param
      body: Center(
        child: GoogleMap(
          polylines: Set<Polyline>.of(_mapPolylines.values),
          myLocationEnabled: true,
          mapType: MapType.normal,
          markers: markers != null ? Set<Marker>.from(markers) : null,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialPosition.latitude,
                  widget.initialPosition.longitude),
              zoom: 18),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 28),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            padding: EdgeInsets.all(12),
            textColor: Colors.white,
            color: Colors.deepOrange,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                startedTracking? Icon(Icons.pause) : Icon(Icons.play_arrow),
                startedTracking?
                Text(
                  " Stop Tracking ",
                  style: TextStyle(fontSize: 19),
                ):
                Text(
                  " Start Tracking ",
                  style: TextStyle(fontSize: 19),
                ),
              ],
            ),
            onPressed:(){
              startedTracking? stopTracking() : startTracking();
              setState(() {
                startedTracking = !startedTracking;
              });
            },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
    //// adding positions and sequences
  }

  void draw() {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);
    LatLng firstPoint = points[_pointId - 1];
    LatLng secondPoint = points[_pointId];
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.deepOrange,
      width: 3,
      points: [firstPoint, secondPoint],
    );
    setState(() {
      _mapPolylines[polylineId] = polyline;
    });
  }

  void _setInitialMarker(Future<Position> initialLocation) async {
    // Start Location Marker
    startMarker = Marker(
      markerId: MarkerId('start'),
      position: LatLng(
          widget.initialPosition.latitude, widget.initialPosition.longitude),
      infoWindow: InfoWindow(
        title: 'Start',
        snippet: "initial point",
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    markers.add(startMarker);
  }

  startTracking() {
    streamSubscription = geoService.getCurrentLocation().listen((position) {
      centerScreen(position);
      addPointToPolylines(position);
    });
  }

  stopTracking() {
    streamSubscription.cancel();
    showSaveRouteDialog(context);
  }

  void showSaveRouteDialog(BuildContext context){
    showDialog(
        context: context,
        child: RouteNameDialog()
    );
  }

}
