import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/foursquare_details/widget/panel_header_widget.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
import 'package:graduation_project/models/foursquare_bookmark_place_details.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graduation_project/constants.dart';
class PanelWidget extends StatelessWidget {
  final FoursquareDetails placeDetails;
  final VoidCallback onClickedPanel;
  final BookmarkPlace place;
  const PanelWidget({
    @required this.place,
    @required this.onClickedPanel,
    Key key, this.placeDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,

          ),

          child: buildProfile(),
        ),
      ),
    ],
  );

  Widget buildProfile() => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onClickedPanel,
    child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(//first container
            height: 15,
            width: 80,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5,top: 5),
              child:RaisedButton(
                  color: Colors.white38,
                  onPressed: (){},
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ) ,
            ),
          ),
          PanelHeaderWidget(
            place:place ,
            placeDetails: placeDetails,
            //onClickedFollowing: onClickedFollowing,
          ),
          SizedBox(height: 14),
          Expanded(child: buildProfileDetails(placeDetails, place)),
        ],
      ),
    ),
  );

  Widget buildProfileDetails(FoursquareDetails placeIn, BookmarkPlace place ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        placeIn.description!='a gallery'?placeIn.description:"",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      Text(placeDetails.isOpen?"Opened":"Closed",style:
      TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:placeDetails.isOpen?
      Colors.green:Colors.red ),),
      SizedBox(height: 12),


      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          StatsWidget(rate: place.rating,),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    spreadRadius: 3,

                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],

                color: kPrimaryLightColor,
                shape: BoxShape.circle
            ),

            child: IconButton(
              icon: Icon(Icons.call_rounded, color: Colors.deepOrange),
              color:placeIn.phoneNumber=='tel:0'? Colors.grey:Colors.deepOrange,
              onPressed: (){

                _makePhoneCall(placeIn.phoneNumber);
              }
            ),
          ),
          SizedBox(width: 14,),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    spreadRadius: 3,

                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],

                color: kPrimaryLightColor,
                shape: BoxShape.circle
            ),

            child: IconButton(

              icon: Icon(Icons.attachment_sharp,
                  color:placeIn.url!='not found'? Colors.deepOrange:Colors.grey),
              color: Colors.grey[200],
              onPressed:  placeIn.url!='not found'?() {
                _launchInBrowser(placeIn.url);

              }:null,
            ),
          ),
        ],
      )
    ],
  );
  Future<void> _makePhoneCall(String num) async {
    if (await canLaunch(num)) {
      await launch(num);
    } else {
      throw 'Could not launch $num';
    }
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
