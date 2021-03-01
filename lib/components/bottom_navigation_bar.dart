import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/constants.dart';

class BottomNavBar extends StatelessWidget {  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          BottomNavItem(
            title: "Today",
            icon: Icons.home,
            isActive: true,
          ),
          RaisedButton(
            padding: EdgeInsets.all(5.0),
color: Colors.deepOrangeAccent,
            shape: CircleBorder(),
            child: Icon(Icons.navigation,color: Colors.white,size: 40,),
            onPressed: () {  },
          ),

          BottomNavItem(
            title: "Explore",
            icon: Icons.explore,
            isActive: false,
          ),

          // BottomNavItem(
          //   title: "Fav Places",
          //   icon: Icons.bookmark,
          // ),
          // BottomNavItem(
          //   title: "Profile",
          //   icon: Icons.person,
          // ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.icon,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: isActive ? kPrimaryColor : Colors.black54,
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? kPrimaryColor : Colors.black54),
          ),
        ],
      ),
    );
  }
}