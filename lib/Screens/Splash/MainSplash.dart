import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/Screens/Welcome/welcome_screen.dart';
import 'dart:async';

import 'package:graduation_project/services/auth.dart';
import 'package:provider/provider.dart';

class MainSplash extends StatefulWidget {
  @override
  _MainSplashState createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), checkIfLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor.withOpacity(0.8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Cockatoo",
              style: GoogleFonts.lobsterTwo(
                fontSize: 60,
              )),
          SizedBox(
            height: 20,
          ),
          SpinKitRipple(
            color: Colors.white,
            size: 100,
          )
        ],
      ),
    );
  }

  void checkIfLoggedIn() async {
    return Provider.of<Auth>(context, listen: false).tryToken().then(
        (loggedIn) =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              if (loggedIn != null && loggedIn == true) {
                return HomeScreen();
              }else{
                return WelcomeScreen();
              }
            }
            ))
    );
  }
}
