import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/services/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';
import 'save_route_dialog.dart';
import 'dart:async';
import 'package:graduation_project/Screens/routeTracking/camera/main.dart';
import '../../gist.dart';
import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/models/path-point.dart';
import 'package:graduation_project/models/general_location.dart';
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
  Position currentLocation;
  List<StoryImage> images=[];
  List<PathPoint> pathPoints=[];
  @override
  void initState() {

    _setInitialMarker(geoService.getInitialLocation());

    super.initState();
  }

  void addPointToPolylines(Position position) {
     points.add(LatLng(position.latitude, position.longitude));
    seq.add(_pointId);
    GeneralLocation location=new GeneralLocation(position.latitude, position.longitude);
    PathPoint point= PathPoint(location,_pointId);
    pathPoints.add(point);

    if (_pointId > 0) draw();
    _pointId++;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // ignore: missing_required_param
      body: Stack(
        children: [
          Center(
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
          Positioned(
            top: height*0.87,
            left: width*0.6,
            child:
            Visibility(
              visible: startedTracking,
              child: InkWell(
                onTap: () {
                  navigateToCamera(context);
                },
                child: Container(
                  height: 73,
                  width: 73,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade500, //                   <--- border color
                      width: 7.0,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 40),
        child: Align(
          alignment: Alignment.bottomLeft,
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
      setState(() {
        currentLocation=position;
        print(currentLocation.toString()+"hello");
      });
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

  void navigateToCamera(BuildContext context)async {
    final List<StoryImage> result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraApp(

      ),),
    );
    if(result!=null) {
      this.images.addAll(result);
      print(images.toString());
    }
  }

}
