import 'package:flutter/cupertino.dart';

import '../constants.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Function press;

  const SocialIcon({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 25,
          color: kPrimaryColor
        ),
      ),
    );
  }
}
