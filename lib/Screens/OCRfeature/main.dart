import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/Screens/OCRfeature/ocr_camera/main.dart';
import 'package:graduation_project/Screens/OCRfeature/ocr_gallery/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainOCR extends StatefulWidget {
  @override
  _MainOCRState createState() => _MainOCRState();
}

class _MainOCRState extends State<MainOCR> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
           Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              IgnorePointer(
                child: Container(
                  color: Colors.transparent,
                  height: 180.0,
                  width: 150.0,
                ),
              ),

              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(200),
                    degOneTranslationAnimation.value * 65),
                child: Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimation.value))
                    ..scale(degOneTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text("Live  ",style: TextStyle(fontSize: 16),),

                      CircularButton(
                        color: Colors.deepOrangeAccent,
                        width: 45,
                        height: 45,
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                        onClick: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return MainCamera();
                              }));                    },
                      ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(150),
                    degThreeTranslationAnimation.value * 55),
                child: Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimation.value))
                    ..scale(degThreeTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text("Image  ",style: TextStyle(fontSize: 16),),
                      CircularButton(
                        color: Colors.deepOrangeAccent,
                        width: 45,
                        height: 45,
                        icon: Icon(
                          Icons.image_outlined,
                          color: Colors.white,
                        ),
                        onClick: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return MainGallery();
                              }));                    },
                      ),
                    ],
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),


                    ),
                    border: Border.all(
                      width: 3,
                      color: kPrimaryLightColor,
                      style: BorderStyle.solid,
                    ),
                  ),

                    child: CircularButton(
                      color: kPrimaryLightColor,
                      width: 40,
                      height: 40,
                      icon: Icon(
                        Icons.camera,
                        color: Colors.deepOrangeAccent,
                      ),
                      onClick: () {
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          checkWelcomeScreen(context);
                          animationController.forward();
                        }
                      },
                    ),
                  ),
              ),

           ]);

  }
  Future checkWelcomeScreen(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seenOcr') ?? false);

    if (!_seen) {
      showDeleteDialog(context);
      await prefs.setBool('seenOcr', true);

    }

  }

  void showDeleteDialog(BuildContext context,) {
    bool deletingDone = false;
    //print(index.toString()+"index");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: new Text(
                "Optical Character Recognition "),
            content: new Text("this feature helps you extracting texts from images and translate them,"
                " enjoy your trip and explore what's around"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  //    reflectDeleting(story, index);
                },
              ),
            ],
          );
        });
  }

}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}
