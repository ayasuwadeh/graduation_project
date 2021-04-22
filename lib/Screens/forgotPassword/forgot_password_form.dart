import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/components/rounded_textField.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/Screens/passwordCode/password_code_screen.dart';
import 'package:graduation_project/services/forgot_password_provider.dart';


class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordForm createState() => _ForgotPasswordForm();
}

class _ForgotPasswordForm extends State<ForgotPasswordForm> {
  Map<String, String> _creds = Map<String, String>();
  bool _autovalidate = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _creds.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      autovalidate: _autovalidate,
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RoundedTextFormField(
            hintText: "Email",
            onSaved: (String val) => _creds['email'] = val,
            validator: _validateEmail,
            autoFocus: true,
          ),
          Provider.of<AuthProvider>(context).codeStatus ==
              ForgotPasswordSendCodeStatus.Sending
              ? Loading()
              : RoundedButton(
            text: "Send to Email",
            press: () {
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
    Provider.of<AuthProvider>(context, listen: false)
        .sendForgotPasswordEmail(email: _creds['email']);

    result.then((response) {
      if (!response['errorStatus']) {
       //TODO: dialog to tell user that en email has been sent
        Provider.of<ForgotPasswordProvider>(context, listen: false).setEmail(_creds['email']);
        print(response['message']);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PasswordCodeScreen();
        }));
      } else {
        // TODO pop up dialog
        print(response['message']);
      }
    });
  }
}
