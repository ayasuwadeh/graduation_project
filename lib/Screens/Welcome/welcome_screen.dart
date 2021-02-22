import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Screens/Login/login_screen.dart';
import 'package:graduation_project/Screens/SignUp/sign_up_screen.dart';
import 'package:graduation_project/Screens/pageviewSignup/mainPage.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/constants.dart';

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

              child: Carousel(
                dotSize: 0,
                dotVerticalPadding: 220,
                dotBgColor: Colors.transparent,
                autoplayDuration: Duration(seconds: 2),
                animationCurve: animation,

                images: [
                  Image.asset('assets/images/china.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/pyramids.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/piza.jpg', fit: BoxFit.cover,)
                ],
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
                                return SignUpView();
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
