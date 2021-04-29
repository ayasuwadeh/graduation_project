import 'package:flutter/material.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project/services/geolocator_service.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/services/sql_lite/image_functions.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ImageReview extends StatefulWidget {
  final StoryImage image;

  ImageReview({Key key, this.image}) : super(key: key);

  @override
  _ImageReviewState createState() => _ImageReviewState();
}

class _ImageReviewState extends State<ImageReview> {
  GlobalKey globalKey = GlobalKey();
  AnimationController _controller;
  var textController = new TextEditingController();

  @override
  void initState() {
    if(widget.image.caption!=null)
      textController.text=widget.image.caption;
    else     textController.text='';
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print(widget.image.path);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              // onTap: toggleWriting,
              // scale: 1,
              // origin: Offset(20, 20),
              child: Container(
                child: Image.network(
                  widget.image.path,
                  height:height,
                  width: width,
                  fit: BoxFit.cover,
                ),),
            ),
          ),
          Positioned(
            bottom: height * 0.27,
            right: 10,
            child: Column(
              children: [

                Container(
                  height: 50,
                  child: IconButton(
                      onPressed: () {
                        shareImage();
                      },
                      color: Colors.white,
                      icon: Icon(
                        Icons.share,
                        size: 30,
                      )),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: 50,
                  child: IconButton(
                      onPressed: () async {
                        downloadImage();
                      },
                      color: Colors.white,
                      icon: Icon(Icons.arrow_downward, size: 30)),
                ),
              ],
            ),
          ),
          Positioned(
            top:  height * 0.8,
            left: width * 0.035,
            child: Row(
              children: [
                InkWell(
                  //visible:isWriting ,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: width * 0.82,
                      height: height * 0.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: TextField(
                            maxLines: null,
                            //onTap: toggleWriting,
                            controller: textController,
                            onSubmitted: (text) {
                              setState(() {
                                // shareText = text;
                              });
                             // toggleWriting();

                            },
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.deepOrange.withAlpha(200)),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Aa',
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 40,
                                    color: Colors.deepOrange.withAlpha(150))),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  width: width * 0.015,
                ),

              ],
            ),
            // SizedBox(height:400 ,)
          ),
        ],
      ),
    );
  }

  void downloadImage() async {
    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    String encode3='';
    http.Response response = await http.get(widget.image.path);
    final bytes = response?.bodyBytes;
    encode3=base64Encode(bytes);


    final newFile = await File(path).writeAsBytes(base64Decode(encode3));

    await GallerySaver.saveImage(newFile.path).then((value) {
      print('saved successfluutt');
    });
    print('noo');
  }


  void shareImage() async{
    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      '${DateTime.now().microsecondsSinceEpoch}.png',
    );
    String encode3='';
    http.Response response = await http.get('http://10.0.2.2:80/story_images/31619654820573831.jpg');
    final bytes = response?.bodyBytes;
    encode3=base64Encode(bytes);

    final newFile = await File(path).writeAsBytes(base64Decode(encode3));

    Share.shareFiles([newFile.path]);

  }

}
