import 'package:flutter/material.dart';
import 'package:graduation_project/components/custom_icons_icons.dart';
import 'package:graduation_project/components/or_divider.dart';
import 'package:graduation_project/components/social_icons.dart';
import 'package:graduation_project/Screens/SignUp/signup_form.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return
      Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
         elevation: 0,
        backgroundColor: Colors.transparent,
         ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.07,
            ),

            Text(
                "Sign Up",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )
            ),
            Container(
              width: 120,
              height: 120,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/icons/cockatoo.png"),
                  )
              ),
            ),
            SignUpForm(),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  icon: CustomIcons.facebook,
                ),
                SocialIcon(
                  icon: CustomIcons.twitter,
                ),
                SocialIcon(
                  icon: CustomIcons.gplus,
                ),
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      )
    );
  }
}



