import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/recommendation_place.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';
import 'package:graduation_project/Screens/Map/map_screen.dart';
import 'package:graduation_project/Screens/place_details/page/main_page.dart';
class RestCard extends StatefulWidget {
  RecommendationPlace recommendationPlace;
  RestCard(this.recommendationPlace);
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
                return PlaceWidget(widget.recommendationPlace);
              }
          ));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          width: size.width*0.86,
          height: 270,
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
                Column(
                  children: [
                    Container(
                      height: 130.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        image: DecorationImage(
                          image:
                           NetworkImage(widget.recommendationPlace.image,),fit:BoxFit.cover
                        )
                        
                        //shape: BoxShape.circle,
                      ),
                     // child: Image.network(widget.recommendationPlace.image,fit: BoxFit.cover,),
                    ),
                    SizedBox(height: size.height*0.02,),

                    Row(children: [
                      Text("     "),
                      Container(
                        width: size.width*0.54,
                        child: Text(

                          widget.recommendationPlace.name + " ",
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
                              return MapSample(gallery:widget.recommendationPlace);
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
                      StatsWidget(rate: widget.recommendationPlace.rating,
                        size:30 ,),
                      Text(" | matching:"+(widget.recommendationPlace.score*100).toStringAsFixed(0).toString()+"%"),
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
