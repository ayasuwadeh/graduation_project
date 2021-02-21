import 'package:flutter/material.dart';

class Choice extends StatefulWidget {
  String _innerText;

  Choice(this._innerText);
  ChoiceState createState() => ChoiceState();
  }


  class ChoiceState extends State<Choice> {
    bool _value=false;

    @override
  Widget build(BuildContext context) {
  return  ChoiceChip(
  selected: _value,
  label: Text(widget._innerText),
    onSelected: (bool ) {
      setState(() {
        _value = !_value;
      });
    },
  );
  }

  }



