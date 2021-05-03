import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/components/stats_widget_comp.dart';
import 'package:graduation_project/models/recommendation_city.dart';

class PageViewWidget extends StatefulWidget {
 final List<RecommendationCity> recommendationCities;

  const PageViewWidget({Key key, this.recommendationCities}) : super(key: key);
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  PageController pageController;
  double viewportFraction=0.8;
  double pageOffset=0;
  List<String>imagesList=[
'https://media-cdn.tripadvisor.com/media/photo-b/1024x250/15/33/f5/de/london.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-b/1024x250/15/33/ff/26/miami.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-b/1024x250/10/5a/f0/9b/img-20170722-133227-largejpg.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-b/1024x250/15/33/f8/04/milan.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-b/1024x250/15/33/f9/4c/athens.jpg'
  ];
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
        itemCount: widget.recommendationCities.length,
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
                    right: width*0.08,
                    left: width*0.001,
                    top:100 - scale*height*0.055 ,
                  bottom: height*0.05,
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
                              colors: [
                                Colors.transparent,
                                Colors.black,
                               Colors.black87,
                              ],
                              begin: Alignment.topCenter,
                              end: new Alignment(1.3, 1.3)
                          ).createShader(Rect.fromLTRB(15, 15, rect.width, rect.height));
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
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(3, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.network(
                                widget.recommendationCities[index].image,
                              width: width,
                              height: height*0.75,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: AnimatedOpacity(
                          opacity: angle==0?1:0,
                          duration: Duration(milliseconds: 50),
                          child:
                              Text(widget.recommendationCities[index].name,style:  GoogleFonts.lobsterTwo(
                                  color: Colors.black87,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.3),),


                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 20,
                        child: AnimatedOpacity(
                            opacity: angle==0?1:0,
                            duration: Duration(milliseconds: 50),
                            child:


                            StatsWidget(rate: widget.recommendationCities[index].rating/2,size: 20,)

                        ),
                      )

                    ],
                  ),
                ),
              ),
              );
            },

    );
  }
}
