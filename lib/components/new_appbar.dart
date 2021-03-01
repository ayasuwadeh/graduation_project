import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/header.dart';
import 'package:graduation_project/Screens/Home/Drawer.dart';

class NewAppBar extends StatefulWidget {
  final GlobalKey <ScaffoldState> scaffoldState;

   NewAppBar({Key key, this.scaffoldState, }) : super(key: key);
  @override
  _NewAppBarState createState() => _NewAppBarState();
}

class _NewAppBarState extends State<NewAppBar> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      key: widget.scaffoldState,

      child: Row(
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: IconButton(

              icon: Image.asset("assets/icons/coockatoo.png"),
              onPressed: (){
                widget.scaffoldState.currentState.openDrawer();

              },
            ),
          ),
          SizedBox(width: 33),
          // Text("Cockatoo",style: GoogleFonts.lobsterTwo(
          //   fontSize: 55,
          // ),)
          Header(),

        ],
      ),
    );

  }
}
