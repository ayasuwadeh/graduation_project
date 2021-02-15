import 'package:flutter/material.dart';

import '../constants.dart';

class CountriesDropDown extends StatefulWidget {
  CountriesDropDown({Key key}) : super(key: key);

  @override
  _CountriesDropDownState createState() => _CountriesDropDownState();
}

class _CountriesDropDownState extends State<CountriesDropDown> {
  String dropdownValue = 'Palestine';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      underline: Container(
        height: 2,
        color: kSecondaryColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Palestine', 'Nablus', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

