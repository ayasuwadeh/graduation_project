import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Login/login_screen.dart';
import 'package:graduation_project/components/already_have_an_account_check.dart';
import 'package:graduation_project/components/custom_icons_icons.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/components/rounded_passwordfield.dart';
import 'package:graduation_project/components/rounded_textField.dart';
import 'package:graduation_project/components/social_icons.dart';
import 'package:graduation_project/constants.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class SignUpScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String countryValue="select Your Country";
  String countryValue1="Select Your Country";
  final focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime _selectedDate;

    _showCountry() {
      setState(() {
        countryValue=countryValue1;
      });

    }


    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[


          Positioned.fill(
            top: size.height * 0.12,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  Text(
                      "continue setting up your profile",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),

                 ///////Country chooser widget
                 GestureDetector(

                     child: Container(

                     width: 330,
                     margin: EdgeInsets.all(15),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.black54),
                         borderRadius: BorderRadius.circular(50),

                   ),
                     padding: const EdgeInsets.all(4),
                     child: FlatButton(
                         child: Row(
                             children:[ Icon(Icons.pin_drop,color: Colors.deepOrange,),
                         Text("  $countryValue",
                             style:TextStyle(color: Colors.black54,fontSize: 16),)]),
                       onPressed: (){

                           showCountryPicker(
                         context: context,

                         showPhoneCode: false, // optional. Shows phone code before the country name.
                         onSelect: (Country country) {
                           countryValue1= country.name;
                           _showCountry();

                         },
                       );}
                     )
                   ),
                 ),

                  /////////////////// birthday picker

                  GestureDetector(
                    onTap: () {

                      FocusScope.of(context).requestFocus(new FocusNode());
                    },

                    child: Container(

                        width: 330,

                        padding: const EdgeInsets.all(2),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: DatePickerWidget(
                            looping: false, // default is not looping
                            firstDate: DateTime(1940, 01, 01),
                            lastDate:  DateTime.now(),
                            initialDate: DateTime(1991, 10, 12),
                            dateFormat: "dd-MMM-yyyy",
                            locale: DatePicker.localeFromString('en'),
                            onChange: (DateTime newDate, _) => _selectedDate = newDate,
                            pickerTheme: DateTimePickerTheme(
                              itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                              dividerColor: Colors.grey,
                            ),
                          ),
                        ),
                    ),
                  ),
                SizedBox(height: 25,),
                RoundedButton(
                    text: "Sign Up",
                    color: kPrimaryColor,
                    textColor: kPrimaryLightColor,
                    press: () {},
                  ),
                  SizedBox(
                    height: size.height * 0.01,
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

                  SizedBox(height: 85,),
                  Container(
                    //top: 600,
                    // left: 120,
                      margin: EdgeInsets.only(left: 95) ,
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_outlined,color: Colors.grey,),

                          Text("you can swipe right or left",style: TextStyle(color: Colors.grey,fontSize: 15),),
                          Icon(Icons.arrow_forward_outlined,color: Colors.grey,),

                        ],
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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


