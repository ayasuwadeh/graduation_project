import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/SignUp/sign_up_screen1.dart';
import 'package:graduation_project/Screens/Recommendation/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:graduation_project/Screens/welcomeSignUp/welcome_sign_up.dart';


class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  PageController controller=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body:
      Stack(
        children:[ PageView(
          children:[
            new SignUpScreen1(),
            new MyHomePage(),
            new WelcomeCard(),
          ],
          scrollDirection: Axis.horizontal,
          // reverse: true,
          // physics: BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (num){
            setState(() {
            });
          },
        ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: new EdgeInsets.symmetric(vertical: 20.0),
            child: SmoothPageIndicator(
                controller: controller,  // PageController
                count:  3,
                effect:  ExpandingDotsEffect(
                  dotColor:  Colors.black,
                  activeDotColor: Colors.deepOrange,
                  dotHeight: 8,
                  dotWidth: 8,
                ),  // your preferred effect
                onDotClicked: (index){
                }
            ),

          ),
        ]
      ),
    );
  }
}


