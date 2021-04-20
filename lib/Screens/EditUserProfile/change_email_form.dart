import 'package:flutter/material.dart';
import 'package:graduation_project/components/dialog.dart';
import 'widgets/underlined_textField.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/models/user.dart';

class ChangeEmail extends StatefulWidget {
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String email;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            "Change My Email",
            style: GoogleFonts.lobsterTwo(
                fontSize: 20, color: Colors.black87),
          ),
        ),
        SizedBox(height: 20,),
        Form(
          key: _key,
          child: Column(
            children: [
              Selector<UserProvider, String>(
                builder: (context, userEmail, child) {
                  return UnderlinedTextFormField(
                    icon: Icons.email_outlined,
                    text: userEmail != null ? userEmail : "Email",
                    validator: _validateEmail,
                    onSaved: (String val) => email = val,
                  );
                },
                selector: (buildContext, userProvider) => userProvider.user.email,
              ),
              Container(
                  width: width * 0.45,
                  child: RoundedButton(
                    text: 'Save Changes',
                    press: () {
                      saveChanges();
                    },
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }

  void saveChanges() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      submitForm();
    }
  }

  void submitForm() {
    final Future<Map<String, dynamic>> result =
    Provider.of<AuthProvider>(context, listen: false)
        .changeEmail(email: email);

    result.then((response) {
      if (response['status']) {
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user: user);
        showDialog(context: context, builder: (BuildContext context){
          return InfoDialog(
            title: 'Email Change',
            text: 'Your email has been successfully changed',
          );
        });
      } else {
        String msg ='';
        if(response['error'] == '[The email has already been taken.]'){
          msg = 'The email is already taken';
        }else{
          msg = 'Something went wrong, please try again later.';
        }
        showDialog(context: context, builder: (BuildContext context){
          return InfoDialog(
            title: 'Email Change',
            text: msg,
          );
        });
        //print(response['message'] + ' ' + response['error']);
      }
    });
  }

  String _validateEmail(var email) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');

    if (email.isEmpty)
      return 'Email cannot be empty';
    else if (!regex.hasMatch(email))
      return "Please enter a valid email address";
    else
      return null;
  }
}


