import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/user_provider.dart';

class CountrySelector extends StatelessWidget {
  final Function onSaved;

  CountrySelector({
    Key key,
    this.onSaved,
  }) : super(key: key);
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //String countryValue = widget.countryName;

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
          child: CountryPicker(onSaved: onSaved)),
    );
  }
}


class CountryPicker extends StatefulWidget {
  const CountryPicker({
    Key key, this.onSaved,
  }) : super(key: key);

  final Function onSaved;

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {

  @override
  Widget build(BuildContext context) {
    String countryName = Provider.of<UserProvider>(context, listen: false)
        .user.country !=
        null
        ? Provider.of<UserProvider>(context, listen: false).user.country
        : 'Select your country';

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return FlatButton(
            child: Row(children: [
              Icon(
                Icons.pin_drop_outlined,
                color: Colors.deepOrange,
              ),
              Text(
                countryName,
                style: TextStyle(fontSize: 16),
              )
            ]),
            onPressed: () {
              showCountryPicker(
                context: context,
                showPhoneCode: false, // optional. Shows phone code before the country name.
                onSelect: (Country country) {
                  setState(() {
                    countryName = country.name;
                    widget.onSaved(countryName);
                  });
                },
              );
            });
      },
    );
  }
}
