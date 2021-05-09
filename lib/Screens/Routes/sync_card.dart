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
import 'package:carousel_slider/carousel_slider.dart';

class SyncCard extends StatefulWidget {
  final UserStory story;
  final bool isOpend;
  SyncCard({Key key, this.isOpend, this.story, }) :
        super(key: key);
  @override
  _RouteCardState createState() => _RouteCardState();
}

class _RouteCardState extends State<SyncCard> {
  bool _isSaved=true;
  bool _isSwiped=false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: ()async
      {
        int result =await Navigator.push(context,
            MaterialPageRoute(builder: (context) {
                return SyncedGridview(widget.story);
            }));//print(index);


      },
      child: Container(
        height: height*0.2,
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius:BorderRadius.circular(20),
        ),

        child: Padding(
          padding: EdgeInsets.only(left:15,right: 15),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                 opacityWidget(widget.story),

]),

                Column(
                  children: [

                    //SizedBox(height: 80,),
                    Align(

                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [
                          SizedBox(height: height*0.046,),
                      Row(
                        children: [//TODO:faded text
                          Text(widget.story.name,style: TextStyle(fontSize: 25
                              ,fontWeight: FontWeight.bold,
                              color: Colors.deepOrange.withAlpha(150)),),
                        ],
                      ),

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
    return  ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius:BorderRadius.circular(500),
      child:
      SizedBox(
        height: 90,
        width: 90,
        child: CarouselSlider(

          items:widget.story.storyImages.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: 100,
                    height: 320,
                    // width: double.infinity,
                    child: Image.network(i.path, fit: BoxFit.cover,width: double.infinity,)
                );
              },
            );
          }).toList(),

          options: CarouselOptions(
            height: 300,


            enlargeCenterPage: false,
            autoPlay: true,
            aspectRatio: 9 / 16,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.easeOutQuart,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            viewportFraction:1
            ,
          ),
        ),
      ),

    );


  }
}
