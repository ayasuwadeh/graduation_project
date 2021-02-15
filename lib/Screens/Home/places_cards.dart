import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/selection_title.dart';
import 'package:graduation_project/components/place_card.dart';

import '../../constants.dart';

class PlacesCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        SelectionTitle(
          text: "Places recommended for you",
          press: (){},
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: size.width,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white12,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                PlaceCard(),
                PlaceCard()
              ],
            ),
          ),
        )
      ],
    );
  }
}
