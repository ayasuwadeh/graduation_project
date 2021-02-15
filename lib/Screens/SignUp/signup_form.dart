import 'package:flutter/cupertino.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/components/rounded_passwordfield.dart';
import 'package:graduation_project/components/rounded_textField.dart';

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
    return Form(
      autovalidate: _autovalidate,
      key: _key,
      child: Column(
        children: <Widget>[
          RoundedTextFormField(
            hintText: "Email",
            onSaved: (String val) => _loginObject['email'] = val,
            validator: _validateEmail,
            autoFocus: true,
          ),
          RoundedPasswordField(
            hintText: "Password",
            //onChanged: (String val) => setState(() => _pass1 = val),
            onSaved: (String val) => _loginObject['password'] = val,
            validator: _validatePassword,
          ),
          RoundedPasswordField(
            hintText: "Confirm Password",
            //onChanged: (String val) => setState(() => _pass1 = val),
            onSaved: (String val) => _loginObject['password'] = val,
            validator: _validateConfirmationPassword,
          ),
          RoundedButton(
            text: "Sign Up",
            press: (){
              _doRegister();
            },
          ),
        ],
      ),
    );
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

  String _validateConfirmationPassword(String pass1) {
    if (pass1.isEmpty)
      return 'Required *';
    else
      return null;
  }

  void _doRegister() {
    // After the first attempt to save, turn on autovalidate to give quicker feedback to the user
    setState(() => _autovalidate = true);
    if (_key.currentState.validate()) {
      // Commit the field values to their variables
      _key.currentState.save();
      print("""
      The user has registered with an email address of '${_loginObject['email']}' 
      and a password of '${_loginObject['password']}'
      """);
    }
  }

}
