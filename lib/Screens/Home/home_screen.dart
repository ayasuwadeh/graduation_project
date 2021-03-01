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
import 'header.dart';
import 'Drawer.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey <ScaffoldState> _scaffoldState=GlobalKey <ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(

        key: _scaffoldState,
         drawer: Drawer(child: MainDrawer(),),
        // appBar: AppBar(title: Text("hh",)),
        bottomNavigationBar: BottomNavBar(),
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
                        SizedBox(width: 33),
                        // Text("Cockatoo",style: GoogleFonts.lobsterTwo(
                        //   fontSize: 55,
                        // ),)
                        Header(),

                      ],
                    ),

                    ]),
                  SizedBox(height: 80),
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

