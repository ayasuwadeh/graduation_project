import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:graduation_project/Screens/OCRfeature/ocr_camera/widget/text_area_widget.dart';
import 'package:clipboard/clipboard.dart';

import 'dart:async';


class MainCamera extends StatefulWidget {
  @override
  _MainCameraState createState() => _MainCameraState();
}

class _MainCameraState extends State<MainCamera> {
  bool _isInitialized=false;
  String obtainedText='Result of scanning';

  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      _isInitialized=true;
    });
    super.initState();
  }

  _startScan() async{
    List <OcrText> tokens=List();
  obtainedText='';

    try {
      tokens=await FlutterMobileVision.read(
        multiple:  true,
        fps: 2,
      );
      for(OcrText text in tokens)
        {print("values are:${text.value}");
        setState(() {
          obtainedText+=text.value+'\n';
        });
        }
    }
    catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },),
          backgroundColor: Colors.white,
          title:
          Text("OCR", style: TextStyle(color: Colors.black87),)
      ),
      body:
           SingleChildScrollView(
             child: Column(
              children: [
                SizedBox(height: height*0.1,),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            shape: BoxShape.circle
                        ),
                        child:
                    IconButton(
                        icon:Icon(Icons.photo_camera,color: Colors.white,),
                        onPressed: _startScan)
                    ),
                    Text("press to scan"),
                  ],
                ),
                // RaisedButton(
                //   onPressed: _startScan,
                // child: Text("press"),),
                SizedBox(height: height*0.06,),
                TextAreaWidget(text:  obtainedText, onClickedCopy: copyToClipboard)
              ],
          ),
           ),


    );
  }
  void copyToClipboard() {
    if (obtainedText.trim() != '') {
       FlutterClipboard.copy(obtainedText);
     }
   }

}
