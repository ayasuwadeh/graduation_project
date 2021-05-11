import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
import 'package:graduation_project/models/foursquare_bookmark_place_details.dart';
import 'package:graduation_project/Screens/Map/map_screen_bookmark.dart';
class PanelHeaderWidget extends StatelessWidget {
  final FoursquareDetails placeDetails;
  final BookmarkPlace place;
 // final VoidCallback onClickedFollowing;

  const PanelHeaderWidget({
    @required this.place,
   // @required this.onClickedFollowing,
    Key key, this.placeDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: buildUser()),
      MaterialButton(

      onPressed: () {Navigator.push(context, MaterialPageRoute(
          builder: (context){
        return MapSample(place:place,details: placeDetails,);
      }
        ));},
      color: Colors.deepOrange,
      textColor: Colors.white,
      child: Icon(
      Icons.location_pin,
      size: 37,
      ),
      padding: EdgeInsets.all(10),
      shape: CircleBorder(),
      ),]
      );





  Widget buildUser() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        place.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 4),
      Text(place.country+","+place.city),
    ],
  );
}
