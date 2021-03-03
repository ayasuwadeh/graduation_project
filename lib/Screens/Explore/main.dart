import 'package:flutter/material.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'page_view_widget.dart';
import 'package:graduation_project/Screens/Home/header.dart';
class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding:EdgeInsets.only(
                top: height*0.08,
                left: 10,),
            child: Row(
              children: [
                // Text("Find Your \nNext Adventure.",
                //   style: TextStyle(
                //     letterSpacing: 1.3,
                //     color: Colors.black87,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 25,
                //     height: 1.3,
                //   ),),
               // SizedBox(width: 30,),


                Header(),

              ],
            ),
          ),
          Expanded(
            child: PageViewWidget(),

          )
        ],
      ),
    );
  }
}

