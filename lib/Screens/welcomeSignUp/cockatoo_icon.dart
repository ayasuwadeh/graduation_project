import 'package:flutter/material.dart';


class CockatooPic extends StatelessWidget {
  final String path;

  const CockatooPic({Key key, this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Positioned(
        top: height*0.1,
        left: width*0.312,
        child: Container(
          width: 150,
          height: 150,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(path,
              )
          ),

        )
    ));

  }
}
