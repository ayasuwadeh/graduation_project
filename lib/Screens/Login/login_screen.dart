import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Screens/SignUp/sign_up_screen.dart';
import 'package:graduation_project/Screens/Login/login_form.dart';
import 'package:graduation_project/components/already_have_an_account_check.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
              child: Opacity(
                child: Image(
                  image: AssetImage("assets/images/pyramids.jpg"),
                  fit: BoxFit.cover,
                ), opacity: 0.7,
              )
          ),
          Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    child: Text(
                      "LOGIN",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      )
                    ), padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  LoginForm(),
                  SizedBox(height: size.height * 0.03,),
                  AlreadyHaveAnAccountCheck(login: true, press: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return SignUpScreen();
                        }
                    ));
                  },)
                ],
              ),
          ),
        ],
      ),
    );
  }
}

