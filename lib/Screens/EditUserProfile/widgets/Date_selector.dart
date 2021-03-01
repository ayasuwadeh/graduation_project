import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';


class DateSelector extends StatefulWidget {
  final DateTime initialDate;

  const DateSelector({Key key, this.initialDate}) : super(key: key);
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },

      child: Container(

        width: 330,

        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: DatePickerWidget(
            looping: false,
            // default is not looping
            firstDate: DateTime(1940, 01, 01),
            lastDate: DateTime.now(),
            initialDate: widget.initialDate,
            dateFormat: "dd-MMM-yyyy",
            locale: DatePicker.localeFromString('en'),
            onChange: (DateTime newDate, _) {
              _selectedDate = newDate;
//print(_selectedDate.toString());
            },
            pickerTheme: DateTimePickerTheme(
              itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
              dividerColor: Colors.deepOrangeAccent,
            ),
          ),
        ),
      ),
    );


  }
}
