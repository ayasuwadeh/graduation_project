import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Recommendation/Choice.dart';

class CardN extends StatefulWidget {
  List <Choice> op;
  String question;
  CardN(this.question, this.op);
  CardNState createState() => CardNState();
}

class CardNState extends State <CardN> {
  @override
  Widget build(BuildContext context) {
    return Container(

          child: Column(

            children: [
              Align(
                alignment: Alignment(-0.9,0),
                child: Text(widget.question,style: TextStyle(fontWeight: FontWeight.bold),
                ),

              ),

              Align(
                alignment: Alignment(-0.4,0),

                child: Wrap(

                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: -5, // gap between lines
                  children:widget.op,

                ),
              ),
              SizedBox(height: 20)
            ],
          ),
    );

  }

}
