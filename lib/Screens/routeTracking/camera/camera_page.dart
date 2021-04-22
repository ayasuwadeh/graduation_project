import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:graduation_project/services/geolocator_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'image-review.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project/models/story-image.dart';
class CameraPage extends StatefulWidget {

  CameraPage({Key key}) : super(key: key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _controller;
  List cameras;
  var video;
  int camerasIndex;
  Future<void> _controllerInitializer;
  bool flashOn = false;
  CameraLensDirection cameraLensDirection;
  List <StoryImage> images=[];


  Future<CameraDescription> getCamera() async {
  cameras = await availableCameras();
  camerasIndex = 0;

  return cameras.first;
  }

  @override
  void initState() {
    super.initState();

    getCamera().then((camera) {
      CameraLensDirection cameraDirection = camera.lensDirection;
      setState(() {
        _controller = CameraController(camera, ResolutionPreset.high);
        _controllerInitializer = _controller.initialize();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: FutureBuilder(
                future: _controllerInitializer,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return Center(

                      child: Container(color: Colors
                          .transparent,), //TODO:enu ye3lq bdl el black screen
                    );
                  }
                })),
        Positioned.fill(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, images);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 150,
                    left: 10,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          shape: BoxShape.circle
                      ),
                      child: ClipOval(
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRggnOl55V7A7sEynikI9AAnS9eaAwhjpiZ4qwM2WHw5kKV3KQWBbC1lecYXxqZkac_73g&usqp=CAU',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 30,
                    right: 60,
                    left: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          child: IconButton(
                            color: Colors.white,
                            icon: flashOn && (camerasIndex != 1)
                                ? Icon(Icons.flash_on)
                                : Icon(Icons.flash_off),
                            onPressed: () {
                              if (camerasIndex == 0)
                                toggleFlash();
                            },

                          ),

                        ),
                        GestureDetector(
                          onLongPress: () async {
                            _startVideoRecording();
                          },
                          onLongPressEnd: (details) async {
                            doneRecordingVideo(context);
                          },
                          onTap: () async {
                            try {
                                takePicture(context);


                            } catch (e) {
                              // If an error occurs, log the error to the console.
                              print(e);
                            }
                          },
                          child: Container(
                            height: 73,
                            width: 73,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade500.withAlpha(100),
                                width: 7.0,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          child: IconButton(
                              onPressed: () {
                                toggleCameraLensDirection();
                              },
                              color: Colors.white,
                              icon: Icon(Icons.cached)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }



  void toggleFlash() {
    setState(() {
      flashOn = !flashOn;
    });
    try {
      flashOn ? _controller.setFlashMode(FlashMode.torch) : _controller
          .setFlashMode(FlashMode.off);
    }
    catch (e) {
      print(e.toString());
    }
  }

  void toggleCameraLensDirection() {
    if (camerasIndex == 0) {
      setState(() {
        camerasIndex = 1;
        flashOn = false;
        _controller =
            CameraController(cameras[camerasIndex], ResolutionPreset.high);
        _controllerInitializer = _controller.initialize();
      });
    }

    else if (camerasIndex == 1) {
      setState(() {
        camerasIndex = 0;

        _controller =
            CameraController(cameras[camerasIndex], ResolutionPreset.high);
        _controllerInitializer = _controller.initialize();
      });
    }
  }


   _startVideoRecording() async {
   await _controller.startVideoRecording();

  }

  Future <String> doneRecordingVideo(BuildContext context) async{
    String path;
     _controller.stopVideoRecording().then((video)
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ImageReview(
                // Pass the automatically generated path to
                // the DisplayPictureScreen widget.
                imagePath: (video.path),
              ),
        ),
      );


    });
     return path;

  }

  void takePicture(BuildContext context, ) async {
    await _controllerInitializer;
    final path =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    final image = await _controller.takePicture();
    final StoryImage result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageReview(
        imagePath: (image.path),
      ),),
    );
    images.add(result);
    print(result.caption.toString()+"back");

  }
}