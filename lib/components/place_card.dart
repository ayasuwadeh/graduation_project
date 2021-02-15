import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Sama Nablus",
                style: TextStyle(fontSize: 16, color: Colors.black),
                maxLines: 2,
              ),
              Text(
                "Park",
                style: TextStyle(
                    fontSize: 14, color: Colors.black45
                ),
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.favorite_border,
              size: 30,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}