import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/components/place_card.dart';

import '../../constants.dart';

class ListScreen extends StatelessWidget {
  final String label;

  const ListScreen({Key key,@required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only( top: 20, left: 20),
              child: Text(
                label,
                style: TextStyle(fontSize: 22,
                fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: size.width,
              //height: size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kPrimaryLightColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    PlaceCard(),
                    PlaceCard(),
                    PlaceCard()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
