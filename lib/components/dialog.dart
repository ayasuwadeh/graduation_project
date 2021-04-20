import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String text;

  const InfoDialog({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(text), // Message which will be pop up on the screen
      // Action widget which will provide the user to acknowledge the choice
      actions: [
        FlatButton(
          textColor: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );

  }
}
