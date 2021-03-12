import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/geolocator_service.dart';
import 'map_tracker.dart';


class MapScreen extends StatelessWidget {
  final geoService= GeolocatorService();
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: ( context)=> geoService.getInitialLocation() ,
      child: Scaffold(
        body:Consumer<Position>(
          builder: (context, position, widget) {
            return (position != null)
                ? LiveMap(initialPosition: position)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

