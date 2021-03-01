import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';

class WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children: [

          Column(children: [
          SizedBox(height: 165),

          Container(
            margin: EdgeInsets.all(20),
            height: 325,
            child: Column(children: [
              // SizedBox(height: 165,),
              Card(
                borderOnForeground: false,
                margin: EdgeInsets.all(15),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [

                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      ' hey, cockatoo would be always around',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'there still many countries to explore, cities to visit, sights to talk to, '
                        'streets to walk through, songs to fall in love with, do not miss the chance, start now not tomorrow, '
                        'we are so glad to be with you wherever you are ',
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
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                      return HomeScreen();
                  }));},
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
            ]),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),

        ]),
          Positioned(
              top: 600,
              left: 120,
              child: Row(
                children: [
                  Icon(Icons.arrow_back_outlined,color: Colors.grey,),
                  Text("you can swipe to left",style: TextStyle(color: Colors.grey,fontSize: 15),),
                ],
              )
          ),

          Positioned(
              top: 60,
              left: 120,
              child: Container(
                width: 150,
                height: 150,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/icons/cockatoo.png"),
                    )
                ),

              )
          ),
      ]),
    );
  }
}
