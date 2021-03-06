import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String errorText;

  const Error({
    Key key, this.errorText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          errorText,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
