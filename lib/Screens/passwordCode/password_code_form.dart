import 'package:flutter/material.dart';
import 'package:graduation_project/components/rounded_textField.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/services/forgot_password_provider.dart';
import 'package:graduation_project/Screens/resetPassword/reset_password_screen.dart';

class PasswordCodeForm extends StatefulWidget {
  PasswordCodeForm();

  @override
  _PasswordCodeFormState createState() => _PasswordCodeFormState();
}

class _PasswordCodeFormState extends State<PasswordCodeForm> {
  String _code;
  bool _autovalidate = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: _autovalidate,
      key: _key,
      child: Column(
        children: [
          RoundedTextFormField(
            hintText: 'Code',
            icon: Icons.lock,
            onSaved: (String val) => _code = val,
            validator: _validateCode,
          ),
          Provider.of<AuthProvider>(context).codeCheck ==
              PasswordCodeCheck.Sending
              ? Loading()
              : RoundedButton(
            text: "Confirm",
            press: () {
              _doRegister();
            },
          ),
        ],
      ),
    );
  }

  String _validateCode(String code) {

    if (code.isEmpty)
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
      submitForm();
    }
  }

  void submitForm() async {
    String email = Provider.of<ForgotPasswordProvider>(context, listen: false).email;
    final Future<Map<String, dynamic>> result =
    Provider.of<AuthProvider>(context, listen: false)
        .validatePasswordResetToken(email: email, code: _code );

    result.then((response) {
      if (!response['errorStatus']) {
        Provider.of<ForgotPasswordProvider>(context, listen: false).setToken(response['token']);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PasswordResetScreen();
        }));
      } else {
        // TODO pop up dialog
        print(response['message']);
      }
    });
  }

}
