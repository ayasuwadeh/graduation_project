import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  final String option1,option2;

  const Options({Key key, this.option1, this.option2}) : super(key: key);
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 100),
      child: IntrinsicHeight(
        child: Row(
          children: [
            FlatButton(onPressed: (){},
                child: Text(widget.option1,style: TextStyle(fontSize: 16),)),
            VerticalDivider(
              thickness: 2,
              width: 20,
              color: Colors.black45,
            ),

            FlatButton(onPressed: (){},
                child: Text(widget.option2,style: TextStyle(fontSize: 16),)),

          ],
        ),
      ),
    );
  }
}
