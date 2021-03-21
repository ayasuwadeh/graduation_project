import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:graduation_project/Screens/Splash/MainSplash.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/auth.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Auth()),
          ],
          child: MyApp(),
      )
  );
}

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


