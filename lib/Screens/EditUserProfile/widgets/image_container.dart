import 'package:flutter/material.dart';


class ImageContainer extends StatefulWidget {
  final String path;

  const ImageContainer({Key key, this.path}) : super(key: key);
  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: 150,
        child: Container(
          width: 150,
          height: 150,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(widget.path),
              )
          ),

        ));

  }
}
