import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
import 'package:graduation_project/Screens/foursquare_details/page/main_page.dart';
import 'package:graduation_project/Screens/google_details/page/main_page.dart';
class BookCard extends StatefulWidget {
final BookmarkPlace place;
  const BookCard(
      {Key key, this.place,
      })
      : super(key: key);

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool _isSaved = true;
  AuthProvider authProvider = new AuthProvider();
  bool dummy=true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return dummy? InkWell(
      onTap: () async{
        widget.place.source=='google'?
        dummy=await Navigator.push(context, MaterialPageRoute(
            builder: (context){
          return PlaceWidgetGoogle(widget.place);

        })):
        dummy=await Navigator.push(context, MaterialPageRoute(
            builder: (context){
          return PlaceWidgetFoursquare(widget.place);
      }));
        setState(() {
          dummy=dummy;
        });
        },
        child: Container(
          height: height * 0.2,
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(20),),
          child: Row(
            children: [
                  Opacity(
                    opacity: 0.8,
                    child: Container(
                      width: 110,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: widget.place.image == 'not found'
                              ? NetworkImage(
                                  'https://t4.ftcdn.net/jpg/01/38/09/45/360_F_138094550_tDdrNPWdyycckV81QF75ov7U2OdE7WSr.jpg')
                              : widget.place.source=='foursquare'?NetworkImage(widget.place.image):
                          NetworkImage("https://maps.googleapis.com/maps/api/place/photo?maxwidth=450&maxheight=1000&photoreference="+widget.place.image+"&key=AIzaSyDA6EANtFodVUNO5AJXKL0m4xyTT3FJvec"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              Container(
                // color: Colors.green,
                width: width*0.547,
                height: height*1,
                child: Stack(
                  children: [
                      Positioned.fill(
                        top: -height*0.08,
                        left:width*0.02,
                        child: Row(
                          children: [
                            Text(
                              widget.place.name ,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xC1090A0A)),
                            ),
                          ],
                        ),
                      ),

                      Positioned.fill(
                        top: height*0.01,
                        left: width*0.007,
                        child: Row(children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.black54,
                            ),
                            Text(
                              widget.place.city + ", " + widget.place.country,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xC1090A0A)),
                              textAlign: TextAlign.left,

                            ),

                        ]),
                      ),
                      Positioned.fill(
                        top: height*0.12,
                        left: width*0.02,
                        child: Row(
                          children: [
                            StatsWidget(rate: widget.place.rating,),
                          ],
                        ),
                      ),

                    ],

                ),
              ),
              Column(
                children: [
                  SizedBox(height: height*0.02),
                      Ink(
                        child: _isSaved == true
                            ? IconButton(
                          iconSize: 35,
                          icon: Icon(
                            Icons.bookmark,
                            color: Colors.deepOrangeAccent,
                          ),
                          onPressed: toggleSaving,
                        )
                            : IconButton(
                          iconSize: 35,
                          icon: Icon(
                            Icons.bookmark_border,
                            color: Colors.deepOrangeAccent,
                          ),
                          onPressed: toggleSaving,
                        ),
                      )

                ],
              )
            ],
          ),
        ),
    ):
    Container();
  }

  void toggleSaving() {
    // print(widget.place.type);
    if(!_isSaved)
    {
      if(widget.place.type=='entertainment')
        {
          authProvider.addEntertainmentBookmark(place:widget.place );

        }

      else if(widget.place.type=='restaurant')
        {

          authProvider.addRestaurantBookmark(restaurant:widget.place );

        }
    }

    if (_isSaved) {
      if (widget.place.type == 'entertainment') {
        authProvider.deleteEntertainmentBookmark(id: widget.place.id);
      } else {
         authProvider.deleteRestaurantBookmark(id: widget.place.id) ;

      }
    }
    setState(() {
      _isSaved = !_isSaved;
    });
  }
}
