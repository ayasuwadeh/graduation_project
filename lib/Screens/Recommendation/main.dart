import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Recommendation/Choice.dart';
import 'package:graduation_project/Screens/Recommendation/card.dart';
import 'package:graduation_project/Screens/welcomeSignUp/welcome_sign_up.dart';

// void main() {
//   runApp(MyApp());
// }

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}*/

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> foods = {
    "Chinese",
    "Mexican",
    "Italian",
    "Indian",
    "Japanese",
   "sushi",
    "Greek",
    "French",
    "Spanish",
    "Arabian",
    "Mediterranean",

    "Thai"

  }.toList();
  List<String> sights = {
    "Beach",
    "Desert",
    "Mountains",
    "wildlife",
    "forests",
    "old cities",
  }.toList();
  List<String> civils = {
    "Canaanites",
    "Romanians ",
    "Greeks",
    "old egyptians",
    "Japanese",
    "Islamic culture",
    "Ottomans"
  }.toList();

  List<Choice> options;

  int id;


  @override
  Widget build(BuildContext context) {
    return Container(


      child:
      Container(
          margin: EdgeInsets.only(top: 50),

          child:Column(
        children: [
          SizedBox(height: 26,),
          Align(
            alignment: Alignment(0,0),
            child: Text("getting to know better",style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.8,
            ),

          ),
          const SizedBox(height: 20),

          Align(
          alignment: Alignment(.5,-7),
          child: Column(
            children: <Widget>[
              // Text(
              //
              //   'what kinds of foods do you like?',
              //   style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18),
              //
              // ),
              Container(
                margin: EdgeInsets.all(10.0),

                child: Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 15, // gap between lines
                    children: [
                      CardN("What types of cuisines do like? ",
                          foods.map((title) => Choice(title)).toList()),
                      CardN("What types of sights do like? ",
                          sights.map((title) => Choice(title)).toList()),

                      CardN("What types of civilisations do like? ",
                          civils.map((title) => Choice(title)).toList()),
                    ]),
              ),

            ],
          ),
        ),
          const SizedBox(height: 27),
            Container(
                //top: 600,
               // left: 120,
              margin: EdgeInsets.only(left: 95) ,
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_outlined,color: Colors.grey,),
                    Text("you can swipe left or right",style: TextStyle(color: Colors.grey,fontSize: 15),),
                    Icon(Icons.arrow_forward_outlined,color: Colors.grey,),

                  ],
                )
            ),


        ],)
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
