import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/hotel.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graduation_project/Screens/google_details/page/main_page.dart';
class SimilarPlaceCard extends StatefulWidget {
  // final AssetImage image;
  // final String name;
  // final String country;

  //final  hotel;
  final BookmarkPlace similarBookmark;

  const SimilarPlaceCard({Key key, this.similarBookmark, }) : super(key: key);

  @override
  _SimilarPlaceCardState createState() => _SimilarPlaceCardState();
}

class _SimilarPlaceCardState extends State<SimilarPlaceCard> {
  bool _isSaved = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return PlaceWidgetGoogle(widget.similarBookmark);
            }
        ));

      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 0),
          child: Container(
            height: height * 0.2,
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 340,
                      child: Row(
                        children: [
                          // SizedBox(width: 10,),
                          Column(
                            children: [
                              //  SizedBox(width: width*0.26,),
                              Container(
                                width: 95,
                                height: 127,
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    shape: BoxShape.rectangle,
                                    image: widget.similarBookmark.image !=
                                        'not found'
                                        ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "https://maps.googleapis.com/maps/api/place/photo?"
                                              "maxwidth=450&maxheight=1000&photoreference="
                                              +widget.similarBookmark.image+"&key=AIzaSyDA6EANtFodVUNO5AJXKL0m4xyTT3FJvec"
                                            ))
                                        : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'))),

                                //  child: Image.network(widget.hotelDetails.image),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child:
                                Row(children: [
                                  Text("     "),
                                  Container(
                                    width: width*0.37,
                                    child: Text(

                                      widget.similarBookmark.name + ", ",
                                      overflow: TextOverflow.fade,

                                      maxLines: 1,
                                      //overflow: TextOverflow.ellipsis,
                                      softWrap: false,

                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xC1090A0A)),
                                    ),
                                  ),
                                  SizedBox(width: width*0.05,),
                                ]),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  StatsWidget(
                                    rate: widget.similarBookmark.rating,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
