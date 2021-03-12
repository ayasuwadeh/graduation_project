import 'package:flutter/material.dart';
import 'package:graduation_project/gist.dart';

class RouteNameDialog extends StatefulWidget {
  @override
  _RouteNameDialogState createState() => _RouteNameDialogState();
}

class _RouteNameDialogState extends State<RouteNameDialog> {
  TextEditingController routeName = TextEditingController();
  bool emptyRouteNameField = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomAlertDialog(
        content: Container(
          width: size.width / 1.2,
          height: size.height * 0.237,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Text("Enter Route Name:"),
              TextField(
                //initialValue: "Hotel route",
                controller: routeName,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: emptyRouteNameField ? Colors.red : Colors.black,
                    ),
                  ),
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: emptyRouteNameField ? Colors.red : Colors.black,
                  ),
                  hintStyle: TextStyle(
                    color: emptyRouteNameField ? Colors.red : Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.deepOrangeAccent,
                  child: MaterialButton(
                    minWidth: size.width / 2,
                    padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                    onPressed: () async {
                      routeName.text.isEmpty? makeErrorBrder(): saveRouteToDB();
                      if(routeName.text.isNotEmpty) Navigator.pop(context);
                    },
                    child: Text(
                      "Save Route",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

  saveRouteToDB() {
    //TODO
  }

  makeErrorBrder() {
    setState(() {
      emptyRouteNameField = true;
    });
  }
  }


