import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RouteCard extends StatefulWidget {
  final AssetImage image;
  final String name;
  final String country;
  final bool isOpend;
   RouteCard({Key key,@required this.image,@required this.name, @required this.country, this.isOpend}) :
        super(key: key);
  @override
  _RouteCardState createState() => _RouteCardState();
}

class _RouteCardState extends State<RouteCard> {
 bool _isSaved=true;
 bool _isSwiped=false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: ()
      {
      },
      child: Padding(
        padding: EdgeInsets.only(left:15,right: 15),
        child: Container(
          height: height*0.2,
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            borderRadius:BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                Colors.white,
                Colors.black,

              ],
              begin: Alignment.centerLeft,
              end: new Alignment(1.7, 1.7)
            )
          ),
          child: Stack(
            children: [
              Opacity(opacity: 0.5,
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image:widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                children: [

                  //SizedBox(height: 80,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 13),
                    child: Align(

                      alignment: Alignment.bottomLeft,
                      child: Row(children:[
                        Text("   "),
                        Icon(Icons.location_pin,color: Colors.black54,),
                        Text(widget.name+", "+widget.country,
                          style: TextStyle(fontSize: 17
                              ,fontWeight: FontWeight.bold,
                          color: Color(0xC1090A0A)),),]),
                    ),
                  ),
                  SizedBox(width: width*0.43,),
                  widget.isOpend?Icon(
                    Icons.double_arrow_rounded,
                    color: Colors.deepOrange.withOpacity(0.50),
                    size: 30,
                  ):
                  Icon(
                    Icons.double_arrow_rounded,
                    color: Colors.deepOrange.withOpacity(0.60),
                    size: 30,
                  ),



                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void toggleSaving() {
    setState(() {
_isSaved=!_isSaved;
    });
    // if(_isSaved)
    //   print("saved");
    // else print("not saved");
  }
}
