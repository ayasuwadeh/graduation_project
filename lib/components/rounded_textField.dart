import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/components/textfield_container.dart';
import 'package:graduation_project/constants.dart';

class RoundedTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool autoFocus;
  final Function onSaved;
  final Function validator;

  const RoundedTextFormField({Key key,
    this.hintText,
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
        decoration: InputDecoration(
          hintText: hintText,
          errorStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
          prefixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 1.5,
            ),
          )
        ),
      )
    );
  }
}
