import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Divider(
              height: 1.5,
              thickness: 3,
              color: Colors.black26,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 1.5,
              thickness: 3,
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }
}