import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'package:graduation_project/components/cockatoo_icon.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/components/loading.dart';

class WelcomeCard extends StatefulWidget {
  @override
  _WelcomeCardState createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        Column(children: [
          SizedBox(height: height * 0.22),
          Container(
            margin: EdgeInsets.all(height * 0.03),
            height: height * 0.47,
            child: Column(children: [
              Card(
                borderOnForeground: false,
                margin: EdgeInsets.all(15),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.052,
                    ),
                    Text(
                      ' hey, cockatoo would be always around',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'there still many countries to explore, cities to visit, sights to talk to, '
                        'streets to walk through, songs to fall in love with, do not miss the chance, start now not tomorrow, '
                        'we are so glad to be with you wherever you are ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: tapped? Loading():
                RaisedButton(
                  padding: EdgeInsets.all(12),
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  child: Text(
                    "    Let's Go!    ",
                    style: TextStyle(fontSize: 19),
                  ),
                  onPressed: () {
                    setState(() {
                      tapped = true;
                    });
                    sendRequests(context);
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
            ]),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ]),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.grey,
                ),
                Text(
                  "you can swipe to left",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        CockatooPic(path: "assets/icons/cockatoo.png"),
      ]),
    );
  }

  void sendRequests(BuildContext context) async {
    List<String> cuisines =
        Provider.of<UserProvider>(context, listen: false).cuisines;
    List<String> cultures =
        Provider.of<UserProvider>(context, listen: false).cultures;
    List<String> natures =
        Provider.of<UserProvider>(context, listen: false).natures;
    String country =
        Provider.of<UserProvider>(context, listen: false).user.country;
    DateTime birthday =
        Provider.of<UserProvider>(context, listen: false).user.birthday;

    if(country != null && birthday != null && cuisines != null && cultures != null && natures != null ){
      final results = await Future.wait([
        Provider.of<AuthProvider>(context, listen: false).storeCultures(cultures: cultures),
        Provider.of<AuthProvider>(context, listen: false).storeCuisines(cuisines: cuisines),
        Provider.of<AuthProvider>(context, listen: false).storeNatures(natures: natures),
        Provider.of<AuthProvider>(context, listen: false).sendCountryAndBirthday(country, birthday)
      ]);
      // success
      if(results[0]['status'] && results[1]['status'] && results[2]['status'] && results[3]['status'])
      {
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return HomeScreen();
            }
        ));
      }else{
        // TODO dialog to tell that sth is wrong
        print('error');
      }

    }else{
      // TODO dialog to tell that sth is empty
      print('sth is empty');
    }
    setState(() {
      tapped = false;
    });
  }
}
