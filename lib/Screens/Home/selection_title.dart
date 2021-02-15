import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectionTitle extends StatelessWidget {
  final String text;
  final GestureTapCallback press;

  const SelectionTitle({Key key, @required this.text, @required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
          InkWell(
            onTap: press,
            child: Text("See more"),
            borderRadius: BorderRadius.circular(15),
          )
        ],
      ),
    );
  }
}