import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/constants.dart';
import 'password_code_form.dart';


class PasswordCodeScreen extends StatelessWidget {
  PasswordCodeScreen();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height:size.height*0.07 ,),
              Padding(
                child: Text(
                    "Forgot Password",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                ), padding: EdgeInsets.symmetric(vertical: 20),
              ),
              SizedBox(height:size.height*0.05 ,),
              Padding(
                child: Text(
                    "Please enter the code sent to your email.",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    )
                ), padding: EdgeInsets.symmetric(horizontal: 40),
              ),
              SizedBox(height:size.height*0.05 ,),
              PasswordCodeForm(),
            ],
          ),
        ),
      ),

    );
  }

}
