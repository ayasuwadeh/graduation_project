import 'package:flutter/material.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project/services/geolocator_service.dart';
import 'package:graduation_project/models/story-image.dart';
import 'dart:convert';
import 'package:graduation_project/models/general_location.dart';
import 'package:graduation_project/api/xampp_util.dart';
class ImageReview extends StatefulWidget {
  final String imagePath;

   ImageReview({Key key, this.imagePath}) : super(key: key);

  @override
  _ImageReviewState createState() => _ImageReviewState();
}

class _ImageReviewState extends State<ImageReview> {
  GlobalKey globalKey= GlobalKey();
  var textController = new TextEditingController();
  bool isWriting=false;
  String inputNote='';
  String caption='';
  final GeolocatorService geoService = GeolocatorService();
  Position currentLocation;
  String base64Image;
  String serverFileName;
  int counter=0;
  @override
  void initState() {
    // TODO: implement initState
     geoService.getInitialLocation().then((value)
     {
       setState(() {
         currentLocation=value;
        print(currentLocation.toString()+"hiii");
       });
     });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print(widget.imagePath);

    return Scaffold(
      resizeToAvoidBottomPadding:false,

      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color:Colors.white,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(//TODO:making the text widget warpping and scrollable
        children: [

          Positioned(
             top: 0,
            left: 0,

          child: GestureDetector(
            child: Transform.scale(
                scale: 1,
                origin: Offset(20,20),
                child: Container(

                    child: Image.file(
                      File(widget.imagePath),
                      fit: BoxFit.fill,
                      width: 420,
                    )
                ),
              ),
          ),
          ),


          Positioned(
            bottom: height*0.27,
            right: 10,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: IconButton(
                      onPressed: () {
                        Share.shareFiles([widget.imagePath],text: caption);
                      },
                      color:Colors.white,
                      icon: Icon(Icons.share,size: 30,)),
                ),
                SizedBox(height: 14,),

                Container(
                  height: 50,
                  child: IconButton(
                      onPressed: () async{
                           downloadImage();
                      },
                      color:Colors.white,
                      icon: Icon(Icons.arrow_downward,size: 30)),
                ),

              ],
            ),
          ),
          Positioned(

            top: isWriting?height*0.4:height*0.8,
            left: width*0.035,
            child:
                Row(
                  children: [

                    InkWell(
                        //visible:isWriting ,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: width*0.82,
                          height: height*0.17,
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),

                          child: Align(
                            alignment: Alignment.center,

                            child: SingleChildScrollView(
                              child: TextField(maxLines: null,
                                onTap: ()
                                {
                                  counter=0;
                                  toggleWriting();
                                },
                                controller: textController,
                                style: TextStyle(fontSize: 30,color: Colors.deepOrange.withAlpha(200)),
                                decoration: InputDecoration(

                                    border: InputBorder.none,
                                    hintText: 'Aa',
                                    hintStyle: TextStyle(fontStyle:FontStyle.normal,fontSize: 40,color: Colors.deepOrange.withAlpha(150))

                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: width*0.015,),
                    Container(
                      //  margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(

                          color: Colors.deepOrange.withAlpha(100),
                          shape: BoxShape.circle
                      ),

                      child: IconButton(
                        icon: Icon(
                          Icons.done,
                          size: 35,color: Colors.white,),

                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if(counter>0|| !isWriting)
                            {
                              saveImageToServer();
                              backToCamera(context);

                            }
                          else if (counter<1)
                            incrementCounter();

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

  void downloadImage() async{
    final path = join(
        (await getTemporaryDirectory()).path,
    '${DateTime.now()}.png',
    );

    final newFile = await File(widget.imagePath).copy(path);

    await GallerySaver.saveImage(newFile.path).then((value)
    {
    print('saved successfluutt');
    });
    print('noo');
  }

  void toggleWriting() {
    setState(() {
      isWriting=!isWriting;
    });
  }

  void saveImageToServer() async{
    base64Image = base64Encode(File(widget.imagePath).readAsBytesSync());
    if (null == widget.imagePath) {
      return;
    }
    setState(() {
      serverFileName = widget.imagePath.split('/').last;

    });
     serverFileName = widget.imagePath.split('/').last;
    String result=await XamppUtilAPI.UPLOAD_IMAGE(serverFileName, base64Image);
    if(result==null)
      {
        print(base64Image);
      }
  }

  void backToCamera(BuildContext context) {
    print(this.textController.text+"nothing");
    serverFileName='http://10.0.2.2:80/story_images/'+serverFileName;
    GeneralLocation generalLocation=new GeneralLocation(this.currentLocation.latitude.toString(),this.currentLocation.longitude.toString());
    StoryImage image=new StoryImage('no id',this.serverFileName,this.textController.text, generalLocation);

    Navigator.pop(context, image);

  }

  void incrementCounter() {
    this.counter++;
    toggleWriting();
  }

}
