import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


class MainSplash extends StatefulWidget {
  @override
  _MainSplashState createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Cockatoo",style:GoogleFonts.dancingScript(
            fontSize: 40,
          ))
        ],
      ),
    );
  }
}
