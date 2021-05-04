import 'package:graduation_project/Screens/bookmarks/date_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/bookmarks/card.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'cardslist.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
class MyBookmarks extends StatefulWidget {
  MyBookmarks({Key key}) : super(key: key);


  @override
  _MyBookmarksState createState() => _MyBookmarksState();
}

class _MyBookmarksState extends State<MyBookmarks> {
  AuthProvider authProvider=new AuthProvider();
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

  List <Icon> icons=//for the header
  [Icon(Icons.clear_all,color: Colors.black,),
    Icon(Icons.restaurant,color: Colors.black,),
    Icon(Icons.nature_people,color: Colors.black,),
  ];
  int _value = 0;
  int index;
  int apiIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
          Navigator.pop(context);
          },),
        backgroundColor: Colors.white,
        title:
            Text("Bookmarks", style: TextStyle(color: Colors.black87),)
      ),
      body:
      ListView(
        children: [
          SizedBox(height: 10,),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0, // gap between adjacent chips

            children: List<Widget>.generate(//header
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
                        print(_value);
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

          FutureBuilder(
              key: ValueKey(_value),
              future: _value==1?authProvider.showRestaurantsBookmarks():_value==2?
              authProvider.showEntertainmentsBookmarks():authProvider.showAllBookmarks(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return Loading();
                    break;
                  case ConnectionState.waiting:
                    return Loading();
                    break;
                  case ConnectionState.none:
                    return Error(errorText: 'No Internet Connection');
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Error(errorText: snapshot.error.toString());
                      break;
                    } else if (snapshot.hasData) {
                      {
                        return CardsList(bookmarks: snapshot.data,);
                      }
                    }
                }
                return Container(
                  color: Colors.white,
                );
              }),




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
