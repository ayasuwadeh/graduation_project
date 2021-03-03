import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';



class PageViewWidget extends StatefulWidget {
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  PageController pageController;
  double viewportFraction=0.8;
  double pageOffset=0;

  @override
  void initState() {
    super.initState();
    pageController=PageController(initialPage: 0,viewportFraction:viewportFraction)
    ..addListener(() {
      setState(() {
        pageOffset=pageController.page;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return PageView.builder(
      controller: pageController,

        itemBuilder: (context,index)
            {
              double scale=max(viewportFraction,
                  ((1-(pageOffset - index).abs()) + viewportFraction));
              double angle= (pageOffset-index).abs();

              if(angle>0.5)
                {
                  angle=1-angle;
                }
              return Container(
                padding: EdgeInsets.only(
                    right: 10,
                    left: 20,
                    top:100 - scale * 45,
                  bottom: 10,
                ),
              child: Transform(
                transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angle),
                alignment: Alignment.center,
                child: Material(
                 // elevation: 2,

                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(Rect.fromLTRB(255, 200, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: InkWell(
                          onTap: (){print("hi");},
                          child: Container(

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 7,
                                  blurRadius: 7,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.asset(
                                "assets/images/pyramids.jpg",
                              width: width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60,
                        left: 20,
                        child: AnimatedOpacity(
                          opacity: angle==0?1:0,
                          duration: Duration(milliseconds: 50),
                          child: Text("Italy",style:  GoogleFonts.lobsterTwo(
                              color: Colors.black87,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.3),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              );
            },
      itemCount: 3,

    );
  }
}
