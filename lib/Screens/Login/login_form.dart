import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/components/rounded_passwordfield.dart';
import 'package:graduation_project/components/rounded_textField.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/status_provider.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/Screens/forgotPassword/forgot_password_screen.dart';
import 'package:graduation_project/components/dialog.dart';


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Map<String, String> _creds = Map<String, String>();
  String _pass1; // Your new password
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
        children: <Widget>[
          RoundedTextFormField(
            hintText: "Email",
            onSaved: (String val) => _creds['email'] = val,
            validator: _validateEmail,
            autoFocus: true,
          ),
          RoundedPasswordField(
            hintText: "Password",
            //onChanged: (String val) => setState(() => _pass1 = val),
            onSaved: (String val) => _creds['password'] = val,
            validator: _validatePassword,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50, top: 10, bottom: 5),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ForgotPasswordScreen();
                  }));
                },
                child: Text(
                  'Forgot password? ',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          Provider.of<AuthProvider>(context).loggedInStatus ==
                  Status.Authenticating
              ? Loading()
              : RoundedButton(
                  text: "LOGIN",
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

  String _validatePassword(String pass1) {
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
      submitForm();
    }
  }

  void submitForm() async {
    final Future<Map<String, dynamic>> result =
        Provider.of<AuthProvider>(context, listen: false)
            .login(email: _creds['email'], password: _creds['password']);

    result.then((response) {
      if (response['status']) {
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user: user);
        Provider.of<StatusProvider>(context, listen: false).setStatus(status: true);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      } else {
        showDialog(context: context, builder: (BuildContext context){
          return InfoDialog(
            title: 'Login Failed',
            text: 'Email or password are incorrect.',
          );
        });
        print(response['message'] + ' ' + response['error']);
      }
    });
  }
}
