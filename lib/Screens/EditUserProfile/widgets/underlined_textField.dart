import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/textfield_container.dart';
import 'package:graduation_project/constants.dart';

class UnderlinedTextFormField extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool autoFocus;
  final Function onSaved;
  final Function validator;

  const UnderlinedTextFormField({Key key,
    this.text,
    this.icon = Icons.person,
    this.onSaved,
    this.validator,
    this.autoFocus = false,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: autoFocus,
        initialValue: text,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
          prefixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          filled: true,
          fillColor: Colors.white,
          border: UnderlineInputBorder(
           // borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 2.5,
            ),
          )
        ),
      )
    );
  }
}
