import 'package:flutter/cupertino.dart';
import 'package:graduation_project/Screens/Home/selection_title.dart';
import 'package:graduation_project/components/adventure_card.dart';

class AdventuresCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SelectionTitle(
          text: "Adventures near you",
          press: () {},
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              AdventureCard(
                text: "Art Galleries",
                image: "assets/images/art_gallery.jpg",
              ),
              AdventureCard(
                text: "Zoo",
                image: "assets/images/zoo.jpg",
              ),
              AdventureCard(
                text: "Park",
                image: "assets/images/park.jpg",
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        )
      ],
    );
  }
}
