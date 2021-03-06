import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class PlaceCard extends StatelessWidget {
  //final String name;
  //final String city;
  //final String country;
  //final String location;

  //const PlaceCard({Key key, this.name = 'Sama nablus', this.city = 'Nablus', this.country, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.05),
      decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:Image(
                  image: AssetImage("assets/images/pyramids.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Container(
            width: size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sama Nablus',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  maxLines: 2,
                ),
                Text(
                  'Park',
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontSize: 14, color: Colors.black45
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.location_on,
              size: 30,
              color: kPrimaryColor
            ),
          )
        ],
      ),
    );
  }
}