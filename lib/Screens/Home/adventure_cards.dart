import 'package:flutter/cupertino.dart';
import 'package:graduation_project/Screens/Home/selection_title.dart';
import 'package:graduation_project/components/adventure_card.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/adventures/gallery/galleries.dart';
import 'grid_adventure.dart';
class AdventuresCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SelectionTitle(
          text: "Adventures near you",
          press: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return GridAdventures('Adventures');
                }
            ));

          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              AdventureCard(
                onTapped: (){Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return Galleries(0,'Art Galleries');
                    }
                ));},
                text: "Art Galleries",
                image: "assets/images/art_gallery.jpg",
              ),
              AdventureCard(
                onTapped: (){Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return Galleries(1,'Zoos');
                    }
                ));},

                text: "Zoo",
                image: "assets/images/zoo.jpg",
              ),
              AdventureCard(
                onTapped: (){Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return Galleries(2,'Parks');
                    }
                ));},
                text: "Park",
                image: "assets/images/park.jpg",
              ),

              AdventureCard(
                onTapped: (){Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return Galleries(3,'Museums');
                    }
                ));},
                text: "Museum",
                image: "assets/images/museum.jpg",
              ),
              AdventureCard(
                onTapped: (){Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return Galleries(4,'Beaches');
                    }
                ));},
                text: "Beach",
                image: "assets/images/beach.jpg",
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
