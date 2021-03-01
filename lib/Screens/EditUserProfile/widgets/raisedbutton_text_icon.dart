import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/EditUserProfile/EditIntrests/main.dart';
class RaisedButtonIconText extends StatelessWidget {
  final String text;
  final IconData icon;

  const RaisedButtonIconText({Key key, this.text, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return                 RaisedButton(
      padding: EdgeInsets.all(5),
      color: Colors.white70,
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return EditInterests();
            }));
      },child: Row(children: [
      Icon(icon),
      Text(text,style: TextStyle(fontSize: 15),)
    ],)
      ,);

  }
}
