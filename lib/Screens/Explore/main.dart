import 'package:flutter/material.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'page_view_widget.dart';
import 'package:graduation_project/components/autocomplete_search_bar.dart';
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
      resizeToAvoidBottomPadding:false,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(activePage: 'Explore',),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding:EdgeInsets.only(
                top: height*0.065,
                ),
            child: Row(
              children: [
              SearchBar(hint:"Find Your Next Adventure"),
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

