import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class CountrySelector extends StatefulWidget {
  final String countryName;

  CountrySelector({
    Key key,
    this.countryName,
  }) : super(key: key);
  @override
  _CountrySelectorState createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  @override
  Widget build(BuildContext context) {
    String countryValue = widget.countryName;
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Container(
          width: size.width * 0.88,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black45, width: 1),
            ),
          ),
          padding: const EdgeInsets.all(0),
          child: FlatButton(
              child: Row(children: [
                Icon(
                  Icons.pin_drop_outlined,
                  color: Colors.deepOrange,
                ),
                Text(
                  "  $countryValue",
                  style: TextStyle(fontSize: 16),
                )
              ]),
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode:
                      false, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    setState(() {
                      countryValue = country.name;
                    });
                  },
                );
              })),
    );
  }
}
