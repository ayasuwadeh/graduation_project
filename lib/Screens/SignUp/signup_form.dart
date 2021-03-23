import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/components/rounded_passwordfield.dart';
import 'package:graduation_project/components/rounded_textField.dart';
import 'package:graduation_project/Screens/pageviewSignup/mainPage.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/models/user.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  Map<String, String> _signUpObject = Map<String, String>();
  String _pass1; // Your new password
  bool _autovalidate = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Form(
      autovalidate: _autovalidate,
      key: _key,
      child: Column(
        children: <Widget>[
          RoundedTextFormField(
            hintText: "Name",
            onSaved: (String val) => _signUpObject['name'] = val,
            validator: _validateName,
            autoFocus: true,
          ),
          RoundedTextFormField(
            hintText: "Email",
            onSaved: (String val) => _signUpObject['email'] = val,
            validator: _validateEmail,
            autoFocus: true,
          ),
          RoundedPasswordField(
            hintText: "Password",
            onChanged: (String val) => setState(() => _pass1 = val),
            onSaved: (String val) => _signUpObject['password'] = val,
            validator: _validatePassword,
          ),
          RoundedPasswordField(
              hintText: "Confirm Password",
              validator: _validateConfirmationPassword,
              onSaved: (String val) =>
                  _signUpObject['password_confirmation'] = val),
          Provider.of<AuthProvider>(context).registeredInStatus ==
                  Status.Registering
              ? CircularProgressIndicator()
              : RoundedButton(
                  text: "Sign Up",
                  press: () {
                    _doRegister();
                  },
                ),
        ],
      ),
    );
  }

  String _validateName(String name) {
    if (name.isEmpty)
      return 'Required *';
    else
      return null;
  }

  String _validateEmail(String email) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');

    if (email.isEmpty)
      return 'Required *';
    else if (!regex.hasMatch(email))
      return "Please enter a valid email address";
    else
      return null;
  }

  String _validatePassword(String pass1) {
    if (pass1.isEmpty)
      return 'Required *';
    else
      return null;
  }

  String _validateConfirmationPassword(String confPass) {
    if (confPass.isEmpty)
      return 'Required *';
    else if (confPass != _pass1) {
      //print(confPass);
      //print( 'pass1' + _pass1);
      return 'Passwords do not match';
    } else
      return null;
  }

  void _doRegister() {
    // After the first attempt to save, turn on autovalidate to give quicker feedback to the user
    setState(() => _autovalidate = true);
    if (_key.currentState.validate()) {
      // Commit the field values to their variables
      _key.currentState.save();
      submitForm();
    }
  }

  void submitForm() async {
    final Future<Map<String, dynamic>> result =
        Provider.of<AuthProvider>(context, listen: false).signUp(
            name: _signUpObject['name'],
            email: _signUpObject['email'],
            password: _signUpObject['password'],
            passwordConfirmation: _signUpObject['password_confirmation']);

    result.then((response) {
      if (response['status']) {
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SignUpView();
        }));
      } else {
        // TODO pop up dialog
        print(response['message'] + ' ' + response['error']);
      }
    });
  }
}
