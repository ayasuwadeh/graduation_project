
import 'package:graduation_project/Screens/bookmarks/date_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/bookmarks/card.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: MyBookmarks(),
    );
  }
}

class MyBookmarks extends StatefulWidget {
  MyBookmarks({Key key}) : super(key: key);


  @override
  _MyBookmarksState createState() => _MyBookmarksState();
}

class _MyBookmarksState extends State<MyBookmarks> {

  var chipsMap = [
    {
      'name': 'all',
    },
    {
      'name': 'restaurants',
    },
    {
      'name': 'sights',
    }
  ];

  List <Icon> icons=[Icon(Icons.clear_all,color: Colors.black,),
    Icon(Icons.restaurant,color: Colors.black,),
    Icon(Icons.nature_people,color: Colors.black,),];
  int _value = 1;
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {              Navigator.pop(context);
          },),
        backgroundColor: Colors.white,
        title: Align(
            alignment: Alignment.topLeft,
            child:
            Text("Bookmarks", style: TextStyle(color: Colors.black87),)

        ),
      ),
      body:
      ListView(
        children: [
          SizedBox(height: 10,),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0, // gap between adjacent chips

            children: List<Widget>.generate(
              3,
                  (int index) {
                return ChoiceChip(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all( Radius.circular(10),)),
                    padding: EdgeInsets.all(10),
                    selectedShadowColor: Colors.black,
                    selectedColor: Colors.deepOrangeAccent,
                    label: Text(chipsMap[index]['name'],style: TextStyle(fontSize: 18,color: Colors.black),),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      });
                      checkValue();
                    },
                    avatar: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: icons.elementAt(index),
                    )
                );
              },
            ).toList(),
          ),


          new BookCard(image: AssetImage("assets/images/pyramids.jpg"),
            name: "Piza Tower",
            country: "Italy",),
          DateDivider(saveDate: new DateTime.now(),),
          new BookCard(image: AssetImage("assets/images/piza.jpg"),
            name: "Piza Tower",
            country: "Italy",),
          new BookCard(image: AssetImage("assets/images/china.jpg"),
            name: "Piza Tower",
            country: "Italy",),
          new BookCard(image: AssetImage("assets/images/piza.jpg"),
            name: "Piza Tower",
            country: "Italy",),
          new BookCard(image: AssetImage("assets/images/piza.jpg"),
            name: "Piza Tower",
            country: "Italy",),
          new BookCard(image: AssetImage("assets/images/piza.jpg"),
            name: "Piza Tower",
            country: "Italy",),


        ],
      ),

    );
  }

  void checkValue() {
    if (_value==null)
      setState(() {
        index=0;
        _value =  index ;
      });

  }

}
