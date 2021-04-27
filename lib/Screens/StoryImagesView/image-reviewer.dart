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
  bool isWriting = false;
  String inputNote = '';
  String shareText = '';
  final GeolocatorService geoService = GeolocatorService();
  Position currentLocation;

  @override
  void initState() {
    if(widget.image.caption!=null)
    textController.text=widget.image.caption;
    else     textController.text='';

    geoService.getInitialLocation().then((value) {
      setState(() {
        currentLocation = value;
        print(currentLocation.toString() + "hiii");
      });
    });
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
                      onPressed: () 
                      {
                        showDeleteDialog(context);
                      },
                      color: Colors.white,
                      icon: Icon(
                        Icons.delete_outlined,
                        size: 30,
                      )),
                ),
                SizedBox(
                  height: 14,
                ),

                Container(
                  height: 50,
                  child: IconButton(
                      onPressed: () {
                        Share.shareFiles([widget.image.path], text: shareText);
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
            top: isWriting ? height * 0.4 : height * 0.8,
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
                        onTap: toggleWriting,
                        controller: textController,
                        onSubmitted: (text) {
                          setState(() {
                            shareText = text;
                          });
                          toggleWriting();

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
                Container(
                  //  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange.withAlpha(100),
                      shape: BoxShape.circle),

                  child: IconButton(
                    icon: Icon(
                      Icons.done,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      toggleWriting();

                      Navigator.pop(context,1);
                      editCaption();
                      //    Navigator.pop(context);
                    },
                  ),
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

    final newFile = await File(widget.image.path).copy(path);

    await GallerySaver.saveImage(newFile.path).then((value) {
      print('saved successfluutt');
    });
    print('noo');
  }

  void toggleWriting() {
    setState(() {
      isWriting = !isWriting;
    });

  }

  void deleteStoryImage(BuildContext context) {
    ImageFunctions.delete(int.parse(widget.image.id));
    Navigator.pop(context,1);
    Navigator.pop(context,1);


  }

  bool showDeleteDialog(BuildContext context) {
    bool deletingDone=false;
   // print(index.toString()+"index");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: new Text("are sure you want to delete this image?"),
            content: new Text("you can confirm by pressing ok"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  deletingDone=true;
                  deleteStoryImage(context);
                },
              ),
            ],
          );
        });
    return deletingDone;
  }

  void editCaption() async{
    int t=await ImageFunctions.update(int.parse(widget.image.id), textController.text);

  }

}
