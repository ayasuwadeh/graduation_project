import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/bookmarks/main.dart';
import 'package:graduation_project/Screens/EditUserProfile/main.dart';
import 'package:graduation_project/Screens/Routes/main.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/services/status_provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/Screens/Login/login_screen.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 65.0,
                  child: Image.asset("assets/icons/cockatoo.png"),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Consumer2<UserProvider, StatusProvider>(
                  builder: (context, userProvider, statusProvider, child) {
                    return Text(
                      (statusProvider.status != null && statusProvider.status  && userProvider.user != null)
                          ? userProvider.user.name
                          : "",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, //Center Column contents horizontally,
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.deepOrange,
                    ),
                    Text(
                      " Location",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 20.0,
        ),

        /////taps
        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditProfile();
            }));
          },
          leading: Icon(
            Icons.edit,
            color: Colors.deepOrange,
          ),
          title: Text(
            "Edit Your Profile",
            style: TextStyle(fontSize: 16),
          ),
        ),

        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyBookmarks();
            }));
          },
          leading: Icon(
            Icons.bookmark,
            color: Colors.deepOrange,
          ),
          title: Text(
            "Your Bookmarks",
            style: TextStyle(fontSize: 16),
          ),
        ),

        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyRoutes();
            }));
          },
          leading: Icon(
            Icons.zoom_out_map_sharp,
            color: Colors.deepOrange,
          ),
          title: Text(
            "Your Routes",
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.settings,
            color: Colors.deepOrange,
          ),
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 110,
        ),
        ListTile(
          onTap: () {
            final Future<Map<String, dynamic>> result =
            Provider.of<AuthProvider>(context, listen: false)
                .logout();
            result.then((response) => {
              if(response['status']){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }))
              }else{
                print('error logging out')
              }
            });
          },
          leading: Icon(
            Icons.logout,
            color: Colors.deepOrange,
          ),
          title: Text(
            "Logout",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ]),
    );
  }
}
