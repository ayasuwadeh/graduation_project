import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'cockatoo_icon.dart';

class WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body:
      Stack(
        children: [

          Column(children: [
          SizedBox(height: height*0.22),

          Container(
            margin: EdgeInsets.all(height*0.03),
            height: height*0.47,
            child: Column(children: [
              // SizedBox(height: 165,),
              Card(
                borderOnForeground: false,
                margin: EdgeInsets.all(15),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [

                    SizedBox(
                      height: height*0.052,
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
                height: height*0.01,
              ),
            ]),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20)
                  ),
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
              top: height*0.896,
              left: width*0.27,
              child: Row(
                children: [
                  Icon(Icons.arrow_back_outlined,color: Colors.grey,),
                  Text("you can swipe to left",style: TextStyle(color: Colors.grey,fontSize: 15),),
                ],
              )
          ),
        CockatooPic(path:"assets/icons/cockatoo.png"),
      ]),
    );
  }
}
