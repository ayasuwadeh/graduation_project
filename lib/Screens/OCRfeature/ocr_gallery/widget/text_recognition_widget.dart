import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:graduation_project/api/firebase_ml_api.dart';
import 'package:graduation_project/Screens/OCRfeature/ocr_gallery/widget/text_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  PermissionStatus _status;

  @override
  void initState() {
    super.initState();
  }

  updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }

  String text = '';
  File image;

  @override
  Widget build(BuildContext context) =>
      Expanded(
        child: Column(
          children: [
            Expanded(child: buildImage()),
            const SizedBox(height: 16),
            ControlsWidget(
              onClickedPickImage: pickImage,
              onClickedScanText: scanText,
              onClickedClear: clear,
            ),
            const SizedBox(height: 16),
            TextAreaWidget(
              text: text,
              onClickedCopy: copyToClipboard,
            ),
          ],
        ),
      );


  Widget buildImage() =>
      Container(
        child: image != null
            ? Image.file(image)
            : Icon(Icons.photo, size: 80, color: Colors.black),
      );

  Future pickImage() async {
    Permission.storage.status.then((value) => updateStatus(value));
    askLocationPermission();
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    if(file!=null)
    setImage(File(file.path));
  }

  Future scanText() async {
    showDialog(
      context: context,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);

    Navigator.of(context).pop();
  }

  void clear() {
    setImage(null);
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }

  void askLocationPermission() {
    Permission.storage.request().then((status) => whenRequested(status));
  }

  whenRequested(PermissionStatus status) {
    if (status.isDenied) {
      showLocationIsNeededDialog(true);
    } else if (Platform.isAndroid && status.isPermanentlyDenied) {
      showLocationIsNeededDialog(false);
    } else {
      print('cannot use gallery');
    }
    updateStatus(status);
  }

  Future<void> showLocationIsNeededDialog(bool completeyDenied) async {
    var textDialog = "";
    completeyDenied
        ? textDialog =
    'Text recognition needs to access your media storage. If you press cancel you will not be able to use this feature.'
        :
    textDialog =
    'text recognition needs to access your media library in order to pick an image. If you press cancel you will not be able to use this feature.';

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Access is needed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(textDialog),
                Text('Would you like to allow accessing your media?'),
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
