import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Details/widget/panel_header_widget.dart';
import 'package:graduation_project/Screens/Details/widget/stats_widget.dart';
import 'package:graduation_project/models/place.dart';

class PanelWidget extends StatelessWidget {
  final Place place;
  final VoidCallback onClickedPanel;

  const PanelWidget({
    @required this.place,
    @required this.onClickedPanel,
    Key key,
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
            boxShadow: [
              BoxShadow(
                color: Colors.black45.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 40,

                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
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
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          PanelHeaderWidget(
            place: place,
            //onClickedFollowing: onClickedFollowing,
          ),
          SizedBox(height: 24),
          Expanded(child: buildProfileDetails(place)),
        ],
      ),
    ),
  );

  Widget buildProfileDetails(Place user) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "details",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      SizedBox(height: 12),
      Text(
        'phone number',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 12),
      StatsWidget(rate: place.rating,)

    ],
  );
}
