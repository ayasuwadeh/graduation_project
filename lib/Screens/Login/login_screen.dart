import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Screens/SignUp/sign_up_screen.dart';
import 'package:graduation_project/Screens/Login/login_form.dart';
import 'package:graduation_project/Screens/pageviewSignup/mainPage.dart';
import 'package:graduation_project/components/already_have_an_account_check.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 120,
              left: 120,
              child: Container(
                width: 150,
                height: 150,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/icons/coockatoo.png"),
                    )
                ),

              )
          ),
          Positioned.fill(
            top: size.height * 0.09,

            child: 
            SingleChildScrollView(
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
                    SizedBox(height: size.height*0.2,),
                    LoginForm(),
                    SizedBox(height: size.height * 0.01,),
                    AlreadyHaveAnAccountCheck(login: true, press: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return SignUpView();
                          }
                      ));
                    },)
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}

