import 'package:flutter/material.dart';
import 'package:graduation_project/components/adventure_card.dart';
import 'package:graduation_project/Screens/adventures/gallery/galleries.dart';
import 'package:graduation_project/constants.dart';
class GridAdventures extends StatelessWidget {
  String title;
  GridAdventures(this.title);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar:  AppBar(

            leading: IconButton(icon:Icon(Icons.arrow_back,color: kPrimaryColor,),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },),
            backgroundColor: Colors.white,
            title:
            Text(this.title, style: TextStyle(color: Colors.black87,fontSize: 22),)
        ),
            body: Padding(
              padding: const EdgeInsets.only(right:12.0),
              child: GridView.count(

                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children:
                  [
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
                  ]
              ),
            )
        )
    );
  }
}
    