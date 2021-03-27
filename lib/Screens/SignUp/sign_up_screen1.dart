import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:provider/provider.dart';

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

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin {
  String countryValue = "Select Your Country";
  String countryValue1 = "Select Your Country";
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    DateTime _selectedDate;


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: size.height * 0.7,
            margin: EdgeInsets.only(top: size.height * 0.15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("Continue setting up your profile",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                  SizedBox(
                    height: size.height * 0.09,
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
                            child: Row(children: [
                              Icon(
                                Icons.pin_drop,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                "  $countryValue",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              )
                            ]),
                            onPressed: () {
                              showCountryPicker(
                                context: context,

                                showPhoneCode:
                                    false, // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  setState(() {
                                    countryValue = country.name;
                                  });
                                  saveCountry(country.name);
                                },
                              );
                            })),
                  ),

                  /////////////////// birthday picker

                  SizedBox(
                    height: 30,
                  ),
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
                          lastDate: DateTime.now(),
                          initialDate: DateTime(1991, 10, 12),
                          dateFormat: "dd-MMM-yyyy",
                          locale: DatePicker.localeFromString('en'),
                          onChange: (DateTime newDate, _) {
                            _selectedDate = newDate;
                            saveBirthday(newDate);
                          },
                          pickerTheme: DateTimePickerTheme(
                            itemTextStyle:
                                TextStyle(color: Colors.black, fontSize: 19),
                            dividerColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 30,
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
                        "you can swipe right",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.grey,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void saveCountry(String country) {
    Provider.of<UserProvider>(context, listen: false).setUserCountry(country: country);
  }

  void saveBirthday(DateTime newDate) {
    Provider.of<UserProvider>(context, listen: false).setUserBirthday(birthday: newDate);
  }
}
