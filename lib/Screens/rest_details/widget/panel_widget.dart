import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/rest_details/widget/panel_header_widget.dart';
//import 'package:graduation_project/Screens/Details/widget/stats_widget.dart';
import 'package:graduation_project/models/inner_restaurant.dart';
import 'package:graduation_project/models/restaurant.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graduation_project/constants.dart';
class PanelWidget extends StatelessWidget {
  final InnerRest innerRest;
  final VoidCallback onClickedPanel;
  final Restaurant restaurant;
  const PanelWidget({
    @required this.innerRest,
    @required this.onClickedPanel,
    Key key, this.restaurant,
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

            // boxShadow: [
            //   BoxShadow(
            //     color: Colors..withOpacity(0.5),
            //     blurRadius: 20,
            //     spreadRadius: 40,
            //
            //     offset: Offset(0, 3), // changes position of shadow
            //   ),
            // ],
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
            innerRest: innerRest,
            restaurant: restaurant,

            //onClickedFollowing: onClickedFollowing,
          ),
          SizedBox(height: 24),
          Expanded(child: buildProfileDetails(innerRest,restaurant)),
        ],
      ),
    ),
  );

  Widget buildProfileDetails(InnerRest innerRest, Restaurant restaurant) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(//TODO:redesign this section & if a restaurant not found to delete & doing see more with search
        restaurant.cus,
        style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18),
      ),
      SizedBox(height: 10),
      Text('_________'),
      SizedBox(height: 7),
      Text(innerRest.isOpen?"Opened":"Closed",style: TextStyle(fontSize: 18,color:innerRest.isOpen?Colors.green:Colors.red ),),
      SizedBox(height: 10),
      Text('_________'),
      innerRest.priceLevel!=-1?
      Text(innerRest.priceLevel==0?"Free":
      innerRest.priceLevel==1? "Inexpensive":
      innerRest.priceLevel==2? "Moderate":
      innerRest.priceLevel==3? "Expensive":
       "Very Expensive"
      ):Container(),


  SizedBox(height: 12),


      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          StatsWidget(rate: restaurant.rating,),
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
              color: Colors.grey[200],
              onPressed: (){
                _makePhoneCall(innerRest.phoneNumber);
              },
            ),
          ),
          SizedBox(width: 14,),
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
