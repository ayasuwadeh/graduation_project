import 'package:flutter/material.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'widgets/underliened_passwordfield.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:graduation_project/components/dialog.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final Map<String, dynamic> _passwordObject = Map<String, dynamic>();
  String _pass1; // Your new password


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        InkWell(
          onTap: () {
            //jumpTo();
          },
          child: Container(
            padding: EdgeInsets.only(left: width * 0.05),
            child: Row(children: [
              Text(
                "Change My Password",
                style: GoogleFonts.lobsterTwo(
                    fontSize: 20, color: Colors.black87),
              ),
              SizedBox(
                width: width * 0.45,
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.black54,
                size: 35,
              )
            ]),
          ),
        ),
        SizedBox(height: 20,),
        Form(
          key: _key,
          child: Column(
            children: [
              UnderlinedPasswordField(
                hintText: "Current Password",
                onSaved: (String val) => _passwordObject['current_password'] = val,
                validator: _validatePassword ,
              ),
              UnderlinedPasswordField(
                hintText: "New Password",
                onSaved: (String val) => _passwordObject['new_password'] = val,
                onChanged: (String val) => setState(() => _pass1 = val),
                validator: _validatePassword,
              ),
              UnderlinedPasswordField(
                hintText: "Confirm Password",
                onSaved: (String val) => _passwordObject['new_password_confirmation'] = val,
                validator: _validateConfirmationPassword,
              ),
              SizedBox(height: 20,),
              Container(
                  width: width * 0.45,
                  child: RoundedButton(
                    text: 'Save Changes',
                    press: () {
                      saveChanges();
                    },
                  )),
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
        .changePassword( currentPassword: _passwordObject['current_password'],
        newPassword: _passwordObject['new_password'], newPasswordConfirmation: _passwordObject['new_password_confirmation'] );

    result.then((response) {
      if (response['status']) {
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user: user);
        print('changed password successfully');
        showDialog(context: context, builder: (BuildContext context){
          return InfoDialog(
            title: 'Password Change',
            text: 'Your password has been successfully changed',
          );
        });
      } else {
        String msg = '';
        if(response['error'] == '[The current password does not match with old password.]'){
          msg = 'Current password is incorrect.';
        }else{
          msg = 'Something went wrong. Please try again later.';
        }
        showDialog(context: context, builder: (BuildContext context){
          return InfoDialog(
            title: 'Password Change',
            text: msg,
          );
        });
        print(response['error']);
      }
    });
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
}
