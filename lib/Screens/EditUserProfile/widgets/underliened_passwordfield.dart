import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/textfield_container.dart';
import 'package:graduation_project/constants.dart';


class UnderlinedPasswordField extends StatefulWidget {
  final String hintText;
  final Function onChanged;
  final Function onSaved;
  final Function validator;
  const UnderlinedPasswordField({Key key, this.hintText, this.onChanged, this.onSaved, this.validator }) : super(key: key);

  @override
  _UnderlinedPasswordFieldState createState() => _UnderlinedPasswordFieldState();
}

class _UnderlinedPasswordFieldState extends State<UnderlinedPasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
          obscureText: _isHidden,
          validator: widget.validator,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
            ),
            hintText: widget.hintText,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: kPrimaryColor,
            ),
            suffixIcon: InkWell(
              onTap: _togglePasswordView,
              child: Icon(
                Icons.visibility,
                color: kPrimaryColor,
              ),
            ),
              filled: true,
              fillColor: Colors.white,
               border:  UnderlineInputBorder(
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

}

