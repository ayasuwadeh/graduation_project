import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/places_cards.dart';
import 'package:graduation_project/Screens/Home/restaurants_cards.dart';
import 'package:graduation_project/Screens/Home/selection_title.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'package:graduation_project/components/place_card.dart';
import 'package:graduation_project/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adventure_cards.dart';
import 'categories.dart';
import 'package:graduation_project/Screens/OCRfeature/main.dart';
import 'Drawer.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey <ScaffoldState> _scaffoldState=GlobalKey <ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return
      Scaffold(

        key: _scaffoldState,
         drawer: Drawer(child: MainDrawer(),),
        bottomNavigationBar: BottomNavBar(activePage: 'Home',),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 3,),
                  Column(
                    children: [
                     // SliverAppBar()
                      Row(
                        children: [
                          Stack(
                          children: [
                            SizedBox(width:size.width*1 ),
                            SizedBox(height:size.height*0.17 ),

                            SizedBox(
                              height: 90,
                              width: 90,
                              child: IconButton(

                                icon: Image.asset("assets/icons/cockatoo.png"),
                                onPressed: (){
                                    _scaffoldState.currentState.openDrawer();
                                },
                              ),
                            ),
                            Positioned(
                              top: size.height*0.037,
                              left: size.width*0.22,
                              child: Text("Cockatoo",style:GoogleFonts.lobsterTwo(
                                fontSize: 37,
                                color: Colors.black54
                              )),
                            ),
                            Positioned(
                                top: -30,
                                  left: size.width*0.63,

                                  child: MainOCR()),

                          ],
                    ),
                        ],
                      ),

                    ]),
                  //SizedBox(height: 35),
                  AdventuresCards(),
                  SizedBox(height: 30),
                  Categories(),
                  SizedBox(height: 30),
                  PlacesCards(),
                  SizedBox(height: 30,),
                  RestaurantsCards()
                ],
              ),
            )),

      );
  }


}

