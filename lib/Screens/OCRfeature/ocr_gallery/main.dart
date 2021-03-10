import 'package:graduation_project/Screens/OCRfeature/ocr_gallery/widget/text_recognition_widget.dart';
import 'package:flutter/material.dart';

class MainGallery extends StatefulWidget {
  @override
  _MainGalleryState createState() => _MainGalleryState();
}

class _MainGalleryState extends State<MainGallery> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            leading: IconButton(icon:Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },),
            backgroundColor: Colors.white,
            title:
            Text("Text Recognition", style: TextStyle(color: Colors.black87),)
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextRecognitionWidget(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
}
