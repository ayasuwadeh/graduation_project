import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/components/textfield_container.dart';
import 'package:graduation_project/constants.dart';


class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final Function onChanged;
  final Function onSaved;
  final Function validator;
  const RoundedPasswordField({Key key, this.hintText, this.onChanged, this.onSaved, this.validator }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
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
              Icons.lock,
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
               border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                  color: kPrimaryColor,
                  width: 1.5,
                  )
                ),
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

