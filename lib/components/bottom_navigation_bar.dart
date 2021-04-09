import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/Screens/Explore/main.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'package:graduation_project/Screens/routeTracking/route_welcoming_screen.dart';

class BottomNavBar extends StatefulWidget {
  final String activePage;

  const BottomNavBar({
    Key key, this.activePage,
  }) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    bool _homeIsActive=false;
    bool _exploreIsActive=false;

    if(widget.activePage=='Home')
     _homeIsActive=true;


    else if(widget.activePage=='Explore')
      _exploreIsActive=true;
    return Container(
      decoration: BoxDecoration(
      color: Colors.white,
      // borderRadius: BorderRadius.all(
      //   Radius.circular(10),
      // ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 7,
          blurRadius: 7,
          offset: Offset(0, 0), // changes position of shadow
        ),
      ],
    ),
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          BottomNavItem(
            title: "Today",
            icon: Icons.home,
            isActive: _homeIsActive,
            press: ()
            {setState(() {
              _homeIsActive=true;
              _exploreIsActive=false;
            });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  })
              );
            },

          ),
          RaisedButton(
            padding: EdgeInsets.all(5.0),
            color: Colors.deepOrange,
            shape: CircleBorder(),
            child: Icon(Icons.navigation,color: Colors.white,size: 40,),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return RouteWelcomeScreen();
                  }));
            },
          ),

          BottomNavItem(
            title: "Explore",
            icon: Icons.explore,
            isActive: _exploreIsActive,
            press: ()
            {setState(() {
              _homeIsActive=false;
              _exploreIsActive=true;
            });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return ExplorePage();
                  })
              );
            },

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
            size: 30,
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