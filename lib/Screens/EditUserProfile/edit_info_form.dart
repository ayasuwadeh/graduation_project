import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/country_selector.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/Date_selector.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/underlined_textField.dart';
import 'package:graduation_project/services/auth_provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/components/rounded_button.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/components/dialog.dart';


class EditInfoForm extends StatefulWidget {
  @override
  _EditInfoFormState createState() => _EditInfoFormState();
}

class _EditInfoFormState extends State<EditInfoForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final Map<String, dynamic> _infoObject = Map<String, dynamic>();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    getInitialValues();
    return Form(
      key: _key,
      child: Column(
        children: [
          Selector<UserProvider, String>(
            selector: (buildContext, userProvider) => userProvider.user.name,
            builder: (context, userName, child) {
              return UnderlinedTextFormField(
                icon: Icons.person_outline,
                text: (userName != null) ? userName : 'Name',
                validator: _validateName,
                onSaved: (String val) => _infoObject['name'] = val,
              );
            },
          ),
          ///////////////country
          CountrySelector(
            onSaved: (String val) =>  _infoObject['country'] = val,
          ),
          ///////////////birthday
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "My Birthday is:",
                  style: TextStyle(fontSize: 16),
                )),
          ),
          DateSelector(
            initialDate: Provider.of<UserProvider>(context, listen: false)
                .user.birthday != null
                ? Provider.of<UserProvider>(context, listen: false).user.birthday
                : new DateTime.now(),
            onSaved: (DateTime val) =>  _infoObject['birthday'] = val.toString(),
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
    );
  }

  void saveChanges() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      submitForm();
    }
  }

  void submitForm() async {
    final Future<Map<String, dynamic>> result =
    Provider.of<AuthProvider>(context, listen: false)
        .editInfo( name: _infoObject['name'],
        birthday: _infoObject['birthday'], country: _infoObject['country'] );

    result.then((response) {
      if (response['status']) {
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user: user);
        showDialog(context: context, builder: (BuildContext context){
          return InfoDialog(
            title: 'Info Change',
            text: 'Your information has been successfully changed',
          );
        });
      } else {
        showDialog(context: context, builder: (BuildContext context){
          return InfoDialog(
            title: 'Info Change',
            text: 'Something went wrong. Please try again later.',
          );
        });
      }
    });
  }

  String _validateName(String name) {
    if(name.isEmpty){
      return 'Name cannot be empty';
    }else
      return null;
  }

  void getInitialValues() {
    User user = Provider.of<UserProvider>(context).user;
    _infoObject['name'] = user!=null && user.name != null? user.name : 'name';
    _infoObject['country'] = user!=null && user.country != null? user.country : 'country';
    _infoObject['birthday'] = user!=null && user.birthday != null? user.birthday.toString() : DateTime.now().toString();
  }
}
