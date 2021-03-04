import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Recommendation/Choice.dart';
import 'package:graduation_project/Screens/Recommendation/card.dart';
import 'package:google_fonts/google_fonts.dart';

class EditInterests extends StatefulWidget {
  EditInterests({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditInterestsState createState() => _EditInterestsState();
}

class _EditInterestsState extends State<EditInterests> {
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
    final controller=ScrollController();
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {              Navigator.pop(context);
          },),
        backgroundColor: Colors.white,
        title: Align(
            alignment: Alignment.topLeft,
            child:
            Text("My Interests", style: TextStyle(color: Colors.black87),)

        ),
      ),
      body: SingleChildScrollView(
        child: Container(


          child:
          Container(
             // margin: EdgeInsets.only(top: 35),
              child:Column(
            children: [
              const SizedBox(height: 26),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Check and uncheck based on your interests",
                    style: GoogleFonts.lobsterTwo(
                      fontSize: 20, color: Colors.black87
                  ),),
                ),
              ),
              SizedBox(height: 10,),
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
              SizedBox(height: 40,),

              Padding(
                padding: EdgeInsets.only(left: 100),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      FlatButton(onPressed: (){},
                          child: Text("Discard Changes",style: TextStyle(fontSize: 16),)),
                      VerticalDivider(
                        thickness: 2,
                        width: 20,
                        color: Colors.black45,
                      ),

                      FlatButton(onPressed: (){},
                          child: Text("Save Changes",style: TextStyle(fontSize: 16),)),

                    ],
                  ),
                ),
              )


            ],)
          ),

          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
