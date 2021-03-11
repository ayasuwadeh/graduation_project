import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'package:graduation_project/Screens/routeTracking/map_screen.dart';
import 'package:graduation_project/components/cockatoo_icon.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'package:graduation_project/constants.dart';

class RouteWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.close, size: 35, color: kPrimaryColor,),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      body: Stack(children: [
        Column(children: [
          SizedBox(height: height * 0.22),
          Container(
            margin: EdgeInsets.all(height * 0.03),
            height: height * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              // SizedBox(height: 165,),
              Card(
                borderOnForeground: false,
                margin: EdgeInsets.all(15),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.052,
                    ),
                    Text(
                      'Route Tracker',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Cockatoo is with you wherever you go, so feel safe and free. Location tracker enables '
                            'you to store the route that you are going. Just click Go and the journey will start!',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  padding: EdgeInsets.all(12),
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  child: Text(
                    "    Let's Go!    ",
                    style: TextStyle(fontSize: 19),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return MapScreen();
                        }));
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.01,
              ),
            ]),
          ),
        ]),
        CockatooPic(path: "assets/icons/cockatoo.png"),
      ]),
    );
  }
}
