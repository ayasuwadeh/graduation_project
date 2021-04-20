import 'package:flutter/material.dart';
import 'package:graduation_project/components/rounded_passwordfield.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/status_provider.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'package:graduation_project/services/forgot_password_provider.dart';
import 'package:graduation_project/components/dialog.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  bool resetting = false;
  bool _autovalidate = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Map<String, String> _resetPassObject = Map<String, String>();
  String _pass1; // Your new password

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: _autovalidate,
      key: _key,
      child: Column(
        children: [
          RoundedPasswordField(
            hintText: "Password",
            onChanged: (String val) => setState(() => _pass1 = val),
            onSaved: (String val) => _resetPassObject['password'] = val,
            validator: _validatePassword,
          ),
          RoundedPasswordField(
              hintText: "Confirm Password",
              validator: _validateConfirmationPassword,
              onSaved: (String val) =>
              _resetPassObject['password_confirmation'] = val
          ),
          resetting
              ? Loading()
              : RoundedButton(
            text: "LOGIN",
            press: () {
              setState(() {
                resetting = true;
              });
              _doRegister();
            },
          ),
        ],
      ),
    );
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
    String email = Provider.of<ForgotPasswordProvider>(context, listen: false).email;
    String token = Provider.of<ForgotPasswordProvider>(context, listen: false).token;

    final Future<Map<String, dynamic>> result =
    Provider.of<AuthProvider>(context, listen: false)
        .resetPassword(email: email, password: _resetPassObject['password'],
        passwordConfirmation: _resetPassObject['password_confirmation'],
      token: token
    );

    setState(() {
      resetting = false;
    });

    result.then((response) {
      if (!response['errorStatus']) {
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user: user);
        Provider.of<StatusProvider>(context, listen: false).setStatus(status: true);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      } else {
        showDialog(context: context, builder: (BuildContext context){
          return InfoDialog(
            title: 'Failed',
            text: response['message'].toString() + '. Please try resetting your password again.',
          );
        });
        print(response['message']);
      }
    });
  }

}
