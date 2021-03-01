import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BookCard extends StatefulWidget {
  final AssetImage image;
  final String name;
  final String country;

  const BookCard({Key key,@required this.image,@required this.name, @required this.country}) :
        super(key: key);
  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
 bool _isSaved=true;
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
                Colors.amberAccent

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
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                      child:
                      Ink(child: _isSaved==true?
                      IconButton(
                        iconSize: 35,
                        icon:  Icon(Icons.bookmark,color: Colors.deepOrangeAccent,),
                        onPressed:toggleSaving,): IconButton(
                        iconSize: 35,
                        icon:  Icon(Icons.bookmark_border,color: Colors.deepOrangeAccent,),
                        onPressed:toggleSaving,)
                        ,)
                  ),
                  SizedBox(height: 40,),
                  Align(

                    alignment: Alignment.bottomLeft,
                    child: Row(children:[
                      Text("   "),
                      Icon(Icons.location_pin,color: Colors.black54,),
                      Text(widget.name+", "+widget.country,
                        style: TextStyle(fontSize: 17
                            ,fontWeight: FontWeight.bold,
                        color: Color(0xC1090A0A)),),]),
                  )

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
