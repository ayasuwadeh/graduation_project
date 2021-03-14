import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:graduation_project/Screens/OCRfeature/ocr_camera/widget/text_area_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:async';


class MainCamera extends StatefulWidget {
  @override
  _MainCameraState createState() => _MainCameraState();
}

class _MainCameraState extends State<MainCamera> {
  bool _isInitialized=false;
  String obtainedText='Result of scanning';

  PermissionStatus _status;

  @override
  void initState() {
    super.initState();
    //Permission.photos.status.then((value) => updateStatus(value));
  }

  updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }

  _startScan() async{
    Permission.camera.status.then((value) => updateStatus(value));
    askLocationPermission();
    FlutterMobileVision.start().then((value) {
      _isInitialized=true;
    });

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
  void askLocationPermission() {
    Permission.camera.request().then((status) => whenRequested(status));
  }

  whenRequested(PermissionStatus status) {
    if (status.isDenied) {
      showLocationIsNeededDialog(true);
    } else if (Platform.isAndroid && status.isPermanentlyDenied) {
      showLocationIsNeededDialog(false);
    } else {
      print('cannot use camera');
    }
    updateStatus(status);
  }

  Future<void> showLocationIsNeededDialog(bool completeyDenied) async {
    var textDialog = "";
    completeyDenied
        ? textDialog =
    'OCR needs to use your camera. If you press cancel you will not be able to use this feature.'
        :
    textDialog =
    'OCR needs to use your camera. If you press cancel you will not be able to use this feature.';

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Camera access is needed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(textDialog),
                Text('Would you like to allow using camera?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Allow'),
              onPressed: () {
                openAppSettings();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
