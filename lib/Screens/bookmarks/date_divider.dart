import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDivider extends StatelessWidget {
  final DateTime saveDate;

  const DateDivider({Key key, @required this.saveDate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Text("  "+this.saveDate.day.toString()+" "+
    returnMonth(this.saveDate)+" "+this.saveDate.year.toString(),
              style: TextStyle(fontSize: 18),),
          Expanded(child:
          Container(child:
          Divider(thickness: 3,))),
        ]);

  }
  String returnMonth(DateTime date) {
    return new DateFormat.MMM().format(date);
  }

}
