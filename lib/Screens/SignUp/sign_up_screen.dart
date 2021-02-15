import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Login/login_screen.dart';
import 'package:graduation_project/components/already_have_an_account_check.dart';
import 'package:graduation_project/components/custom_icons_icons.dart';
import 'package:graduation_project/components/or_divider.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/components/rounded_passwordfield.dart';
import 'package:graduation_project/components/rounded_textField.dart';
import 'package:graduation_project/components/social_icons.dart';
import 'package:graduation_project/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
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

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
            child: Opacity(
          child: Image(
            image: AssetImage("assets/images/piza.jpg"),
            fit: BoxFit.cover,
          ),
          opacity: 0.7,
        )),
        Positioned.fill(
          top: size.height * 0.1,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign Up",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                RoundedTextFormField(
                  hintText: "Email",
                  icon: Icons.person,
                ),
                RoundedPasswordField(
                  hintText: "Password",
                ),
                RoundedPasswordField(
                  hintText: "Confirm Password",
                ),
                RoundedButton(
                  text: "Sign Up",
                  color: kPrimaryColor,
                  textColor: kPrimaryLightColor,
                  press: () {},
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                ),
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
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  Map<String, String> _loginObject = Map<String, String>();
  String _pass1; // Your new password
  bool _autovalidate = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RoundedTextFormField(
          hintText: "Email",
          icon: Icons.person,
        ),
        RoundedPasswordField(
          hintText: "Password",
        ),
        RoundedPasswordField(
          hintText: "Confirm Password",
        ),
        RoundedButton(
          text: "Sign Up",
          color: kPrimaryColor,
          textColor: kPrimaryLightColor,
          press: () {},
        ),
      ],
    );
  }
}


