import 'package:flutter/material.dart';
import 'package:graduation_project/gist.dart';
import 'package:graduation_project/services/sql_lite/sqlflite_services.dart';
import 'package:graduation_project/services/sql_lite/image_functions.dart';
import 'package:graduation_project/services/sql_lite/story_functions.dart';
import 'package:graduation_project/services/sql_lite/point_functions.dart';
import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/models/path-point.dart';
import 'package:graduation_project/Screens/Home/home_screen.dart';
class RouteNameDialog extends StatefulWidget {
    List<StoryImage> images;
    List <PathPoint> points;
    RouteNameDialog(this.images,this.points);
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

  saveRouteToDB() async{
    final sqlLiteInstance = SQLService.instance;
    createStory();
    Navigator.pop(context);
    Navigator.pop(context);
  }

  makeErrorBrder() {
    setState(() {
      emptyRouteNameField = true;
    });
  }

  void createStory() async{
    Map<String, dynamic> row = {
      'name':routeName.text,
      'city':'Paris',
      'country':'France'
    };
    final id = await StoryFunctions.insert(row);
    print('inserted row id in story: $id');
    addImages(id);
    addPoints(id);
    final allRows = await StoryFunctions.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void addImages(int id) async{
    for (var item in widget.images)
      {
        Map<String, dynamic> row = {
          'description':item.caption,
          'path':item.path,
          'lat':item.location.lat,
          'lng':item.location.lan,
          'story_id': id
        };
        final idImage = await ImageFunctions.insert(row);
        print('inserted row id in images: $idImage');
      }
    // final allRows = await ImageFunctions.queryAllRows();
    // print('query all rows:');
    // allRows.forEach((row) => print(row));


  }

  void addPoints(int id) async{
    for (var item in widget.points)
    {
      Map<String, dynamic> row = {
        'lat':item.location.lat,
        'lng':item.location.lan,
        'seq':item.sequence,
        'story_id':id
      };
      final idPoint = await PointFunctions.insert(row);
      print('inserted row id in points: $idPoint');

    }
      // final allRows = await PointFunctions.queryAllRows();
      // print('query all rows:');
      // allRows.forEach((row) => print(row));

  }

}


