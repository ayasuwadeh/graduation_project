import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Map/map_screen.dart';
import 'package:graduation_project/models/inner_restaurant.dart';
//import 'package:details_screen/widget/follow_button_widget.dart';
import 'package:graduation_project/models/recommendation_place.dart';
class PanelHeaderWidget extends StatelessWidget {
  final RecommendationPlace recommendationPlace;
 // final VoidCallback onClickedFollowing;

  const PanelHeaderWidget({
   // @required this.onClickedFollowing,
    Key key, this.recommendationPlace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: buildUser()),
      MaterialButton(

      onPressed: () {Navigator.push(context, MaterialPageRoute(
          builder: (context){
        return MapSample(gallery:recommendationPlace);
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
        recommendationPlace.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 4),
      Text('France'+","+'Paris'),
    ],
  );
}
