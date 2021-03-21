import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Routes/card.dart';
import 'package:graduation_project/Screens/bookmarks/date_divider.dart';
import 'package:toast/toast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:graduation_project/gist.dart';
import 'routeMap.dart';
class MyRoutes extends StatefulWidget {
  @override
  _MyRoutesState createState() => _MyRoutesState();
}

class _MyRoutesState extends State<MyRoutes> {
  @override
  Widget build(BuildContext context) {
    String f="";
    String f1="";
    final mq = MediaQuery.of(context);
    bool opend=false;
    void showAlertDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController _emailControllerField =
            TextEditingController();
            return CustomAlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height *0.237,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text("Edit Route Name:"),
                    TextFormField(
                      //initialValue: "Hotel route",
                      controller: TextEditingController(text: "hotel"),
                      decoration: InputDecoration(

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        //hintText: "something@example.com",

                        labelText: "Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black,
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
                          minWidth: mq.size.width / 2,
                          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                          child: Text(
                            "Save Changes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                             Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
    void handleSlideIsOpenChanged(bool isOpen) {
      setState(() {
        opend = isOpen ? true : false;
      });
    }

    final SlidableController slidableController = SlidableController(//TODO change the icon when sliding
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );



    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },),
          backgroundColor: Colors.white,
          title:
          Text("My Routes", style: TextStyle(color: Colors.black87),)
      ),
      body:
      ListView.builder(
        padding: EdgeInsets.only(top: 20),
        itemCount: 10,
        itemBuilder: (context,index){
          return Slidable(key: ValueKey(index),
              controller: slidableController,
              child: RouteCard(image: AssetImage("assets/images/route.jpg"),
            name: "Piza Tower",
            country: "Italy",
              isOpend: opend,),
              actionPane: SlidableDrawerActionPane(),

              secondaryActions: <Widget>[
                IconButton(
                  iconSize: 40,
                  color: Colors.deepOrangeAccent,
                  icon: Icon(Icons.location_on_outlined),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return RouteMap();
                        }));//print(index);
                  },
                ),
                IconButton(
                  iconSize: 40,
                  color: Colors.deepOrangeAccent,
                  icon: Icon(Icons.edit_outlined),
                  onPressed:(){
                    showAlertDialog(context);
                  }
                ),

                IconButton(
                  iconSize: 40,
                  color: Colors.deepOrangeAccent,
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    Toast.show("route has been deleted", context,
                        duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);

                  },
                ),

              ],
          );
        },

      ),

    );

  }
}
