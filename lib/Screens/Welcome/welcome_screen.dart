import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Screens/Login/login_screen.dart';
import 'package:graduation_project/Screens/SignUp/sign_up_screen.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
     Curve animation=Curves.easeInOutCirc ;
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(

              child: CarouselSlider(

                items: [
                  'assets/images/china.jpg',
                'assets/images/pyramids.jpg',
                 'assets/images/piza.jpg', ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: double.infinity,
                          child: Image.asset(i, fit: BoxFit.cover,width: double.infinity,)
                      );
                    },
                  );
                }).toList(),

                options: CarouselOptions(
                  height: size.height,

                  enlargeCenterPage: false,
                  autoPlay: true,
                  aspectRatio: 9 / 16,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.easeInOut,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  viewportFraction:1
                  ,
                ),
              ),

          ),
          Positioned(
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                      "A new \nway to travel ! ",
                      style: GoogleFonts.bigShouldersDisplay(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      )
                  ),
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RoundedButton(
                        text: "LOGIN",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              }));
                        },
                      ),
                      RoundedButton(
                        text: "SIGN UP",
                        press: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SignUpScreen();
                              }
                          ));
                        },
                        color: kPrimaryLightColor,
                        textColor: Colors.black,
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
