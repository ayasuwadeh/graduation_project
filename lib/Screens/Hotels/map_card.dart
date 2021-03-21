import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/hotel.dart';
import 'package:graduation_project/models/hotel_details.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';

class MapCard extends StatefulWidget {
  // final AssetImage image;
  // final String name;
  // final String country;

  final Hotel hotel;
  final HotelDetails hotelDetails;
  const MapCard({Key key, this.hotel, this.hotelDetails}) : super(key: key);
  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  bool _isSaved=true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: ()
      {
      },
      child: Padding(
        padding: EdgeInsets.only(left:0,right: 0),
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
                      borderRadius:BorderRadius.circular(20),
                    ),

                    width: 340,
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Container(
                              width: 95,
                              height: 95,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.rectangle,
                              ),
                             // child: Image.network(widget.hotelDetails.image),

                            ),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40,),
                            Align(

                              alignment: Alignment.bottomLeft,
                              child: Row(children:[
                                Text(" "),
                                Text(widget.hotel.name+", ",
                                  style: TextStyle(fontSize: 17
                                      ,fontWeight: FontWeight.bold,
                                      color: Color(0xC1090A0A)),),]),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 12,),
                                StatsWidget(rate: widget.hotelDetails.rating,),
                              ],
                            ),
                          ],
                        ),
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

}
