import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/restaurant.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';
import 'package:graduation_project/Screens/Map/map_screen.dart';
import 'package:graduation_project/Screens/rest_details/page/main_page.dart';
class RestCard extends StatefulWidget {
  Restaurant restaurant;
  RestCard(this.restaurant);
  @override
  _RestCardState createState() => _RestCardState();
}

class _RestCardState extends State<RestCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child:
         InkWell(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(
                 builder: (context){
                   return PlaceWidget(widget.restaurant);
                 }
             ));
           },
           child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: size.width*0.86,
              height: 120,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 3,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],

                borderRadius: BorderRadius.circular(20),
                color: kPrimaryLightColor,
              ),
              child:  Column(
                  children: <Widget>[
                    SizedBox(height: size.height*0.02,),
                    Column(
                      children: [
                        // Container(
                        //   child: Image.asset("assets/images/rest.jpg"),
                        // ),
                        Row(children: [
                          Text("     "),
                          Container(
                            width: size.width*0.54,
                            child: Text(

                              widget.restaurant.name + " ",
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
                          SizedBox(width: size.width*0.05,),
                          MaterialButton(

                            onPressed: () {Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return MapSample(gallery:widget.restaurant);
                                }
                            ));},
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.location_pin,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(10),
                            shape: CircleBorder(),
                          ),
                        ]),
                      ],
                    ),
                    Padding(

                      padding: const EdgeInsets.only(left:12.0),
                      child: Row(
                        children: [
                          StatsWidget(rate: widget.restaurant.rating,
                                      size:30 ,),
                          Text(" | matching:"+(widget.restaurant.score*100).toStringAsFixed(0).toString()+"%"),
                        ],
                      ),
                    ),
                 //   Text(widget.restaurant.cus),


  ]),
            ),
         ),


    );
  }
}
