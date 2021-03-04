import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Welcome/welcome_screen.dart';

import 'constants.dart';
import 'package:graduation_project/Screens/Splash/MainSplash.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: "Flutter App",
      theme: ThemeData(
        colorScheme:ColorScheme.light().copyWith(
          primary: Colors.deepOrange,
        ) ,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainSplash(),
    );
  }

}


