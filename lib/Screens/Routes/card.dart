import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/StoryImagesView/gridview-images.dart';
import 'package:graduation_project/models/user-story.dart';
import 'package:jiffy/jiffy.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/services/sql_lite/image_functions.dart';
import 'package:graduation_project/api/story-sql-api.dart';
import 'dart:convert';
import 'package:graduation_project/Screens/StoryImagesView/synced_gridviwe.dart';

class RouteCard extends StatefulWidget {
  final UserStory story;
  final bool isOpend;
   RouteCard({Key key, this.isOpend, this.story, }) :
        super(key: key);
  @override
  _RouteCardState createState() => _RouteCardState();
}

class _RouteCardState extends State<RouteCard> {
 bool _isSaved=true;
 bool _isSwiped=false;
 bool changed=false;
 StorySQLApi storySQLApi=new StorySQLApi();

 @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: ()async
      {
        int result =await Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return widget.story.synced=='false'?
              StoryGridView( widget.story,):
                  SyncedGridview(widget.story);
            }));//print(index);


      },
      child: Padding(
        padding: EdgeInsets.only(left:15,right: 15),
        child: Container(
          height: height*0.2,
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            borderRadius:BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                Colors.white,
                Colors.black,

              ],
              begin: Alignment.centerLeft,
              end: new Alignment(1.7, 1.7)
            )
          ),
          child: Stack(
            children: [
              FutureBuilder(
                key: ValueKey(changed),
                  future: storySQLApi.fetchStory(int.parse(widget.story.id)),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                        return Container();
                        break;
                      case ConnectionState.waiting:
                        return Container();
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

                            if(snapshot.data.length>0)
                            return opacityWidget(snapshot.data[0]);

                          }
                        }
                    }
                    return Container(
                      color: Colors.white,
                    );
                  }),



              Row(
                children: [

                  //SizedBox(height: 80,),
                   Align(

                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [
                          SizedBox(height: height*0.046,),
                          FutureBuilder(
                            key: ValueKey(changed),
                              future: storySQLApi.fetchStory(int.parse(widget.story.id)),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.active:
                                    return Container();
                                    break;
                                  case ConnectionState.waiting:
                                    return Container();
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
                                        return Row(
                                          children: [//TODO:faded text
                                            Text(snapshot.data[0].name,style: TextStyle(fontSize: 25
                                                ,fontWeight: FontWeight.bold,
                                                color: Colors.deepOrange.withAlpha(150)),),
                                          ],
                                        );

                                      }
                                    }
                                }
                                return Container(
                                  color: Colors.white,
                                );
                              }),

                          SizedBox(height: height*0.02,),
                          Row(children:[
                            Text("   "),
                            Icon(Icons.location_pin,color: Colors.black54,),
                            Text(widget.story.city+", "+widget.story.country,
                              style: TextStyle(fontSize: 17
                                  ,fontWeight: FontWeight.bold,
                              color: Color(0xC1090A0A)),),]),
                          Text(Jiffy(widget.story.time).fromNow().toString())
                        ],
                      ),
                    ),
                  // SizedBox(width: width*0.3,),
                  // widget.isOpend?Icon(
                  //   Icons.double_arrow_rounded,
                  //   color: Colors.deepOrange.withOpacity(0.50),
                  //   size: 30,
                  // ):
                  // Icon(
                  //   Icons.double_arrow_rounded,
                  //   color: Colors.deepOrange.withOpacity(0.60),
                  //   size: 30,
                  // ),



                ],
              )
            ],
          ),
        ),
      ),
    );
  }
 
  void toggleSaving() {
    setState(() {
_isSaved=!_isSaved;
    });
  }

  Widget opacityWidget(UserStory story)
  {
    return Opacity(opacity: 0.5,
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          image: DecorationImage(
            image:story.storyImages.length>0?
            story.synced!='false'?MemoryImage(base64Decode(story.storyImages[0].path)):
            NetworkImage(story.storyImages[0].path):
            NetworkImage('https://t4.ftcdn.net/jpg/01/38/09/45/360_F_138094550_tDdrNPWdyycckV81QF75ov7U2OdE7WSr.jpg'),

            fit: BoxFit.cover,
          ),
        ),
        // child: Image.memory(base64Decode(storyList[0].storyImages[0].path),fit: BoxFit.contain,),
      ),
    );

  }
}
