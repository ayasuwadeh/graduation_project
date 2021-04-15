import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/place_details/widget/panel_header_widget.dart';
//import 'package:graduation_project/Screens/Details/widget/stats_widget.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:graduation_project/models/recommendation_place.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:graduation_project/constants.dart';
class PanelWidget extends StatelessWidget {
  final VoidCallback onClickedPanel;
  final Function onScrolledPanel;

  final RecommendationPlace recommendationPlace;
   ScrollController _scrollController = ScrollController();

   PanelWidget({
    @required this.onClickedPanel,
    Key key, this.recommendationPlace, this.onScrolledPanel,
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
            recommendationPlace: recommendationPlace,

            //onClickedFollowing: onClickedFollowing,
          ),
          SizedBox(height: 24),
          Expanded(child: buildProfileDetails(recommendationPlace)),
        ],
      ),
    ),
  );

  Widget buildProfileDetails( RecommendationPlace recommendationPlace) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      
      Container(

        height: 100,
        child: FadingEdgeScrollView.fromSingleChildScrollView(
          gradientFractionOnEnd: 0.5,

          child: SingleChildScrollView(
            controller: _scrollController,
            child: Text(//TODO:redesign this section & if a restaurant not found to delete & doing see more with search
              recommendationPlace.description,
              style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 18),
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      // Text('_________'),



  SizedBox(height: 12),


      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          StatsWidget(rate: recommendationPlace.rating,),
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
                _makePhoneCall(recommendationPlace.phoneNumber);
              },
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
