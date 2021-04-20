import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'package:graduation_project/services/user_preferences.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'constants.dart';
import 'package:graduation_project/Screens/Splash/MainSplash.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'services/status_provider.dart';
import 'services/forgot_password_provider.dart';

import 'models/user.dart';

void main() {
  runApp(

      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AuthProvider()),
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context) => StatusProvider()),
            ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
          ],
          child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

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
      home: Scaffold(
        body:
        FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.active:
                return CircularProgressIndicator();
                break;
              case ConnectionState.waiting:
                return CircularProgressIndicator();
                break;
              case ConnectionState.none:
                return Text('No Internet Connection');
                break;
              case ConnectionState.done:
                if(snapshot.hasError){
                  print('errorrrrrr');
                  return Text(snapshot.error.toString());
                }
                else if(snapshot.hasData && snapshot.data.token == null)
                  return MainSplash();
                else if(snapshot.data.token != null){
                  //UserPreferences().removeUser();
                  print('token ' +  snapshot.data.token);
                  Provider.of<UserProvider>(context, listen: false).setUser(user: snapshot.data, notify: false);
                  Provider.of<StatusProvider>(context, listen: false).setStatus(status: true, notify: false);
                  return HomeScreen();
                }
            }
            return Container();
          },
        ),
      ),
    );
  }

}


