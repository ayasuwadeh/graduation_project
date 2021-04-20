import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graduation_project/Screens/place_details/widget/panel_widget.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/api/similar_places.dart';
import 'package:graduation_project/models/recommendation_place.dart';
import 'similar_place_card.dart';
class PlaceWidget extends StatelessWidget {
  RecommendationPlace recommendationPlace;
  List<RecommendationPlace> similarPlacesList;
  PlaceWidget(this.recommendationPlace);
  //InnerRest innerRest;
  SimilarPlacesRecommendationApi similarPlacesRecommendationApi = SimilarPlacesRecommendationApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: similarPlacesRecommendationApi.getData(recommendationPlace.id),
        builder: (BuildContext context,
            AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return Loading();
              break;
            case ConnectionState.waiting:
              return Loading();
              break;
            case ConnectionState.none:
              return Error(errorText: 'No Internet Connection');
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Error(errorText: snapshot.error
                    .toString());
                break;
              }
              else if (snapshot.hasData) {
                {print(snapshot.data);
                similarPlacesList=snapshot.data;
                //print("kkkk");
                return MainPage(recommendationPlace,similarPlacesList);
                }
              }
          }
          return Container(color: Colors.white,);
        }
    );

  }
}
class MainPage extends StatefulWidget {
  //InnerRest innerRest;
  RecommendationPlace recommendationPlace;
  List<RecommendationPlace> similarPlacesList;

  MainPage(this.recommendationPlace,this.similarPlacesList);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 // final place = widget.placeDetails;
  final ScrollController _scrollController = ScrollController();
  ScrollController controller=ScrollController();
  final panelController = PanelController();
  bool isBooked=false;
  bool isLiked=false;
  bool isSimilarOpened=false;
  bool isPanelClosedPlaces=false;

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(//TODO: convert the text of description to scrollable one
        children: [
          SlidingUpPanel(
            backdropColor: Colors.transparent,
            maxHeight: 440,
            minHeight: 250,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            controller: panelController,
            color: Colors.transparent,

            body:Container(
              height: 100,
              child: PageView(
                //reverse: true,
                children: [
                  SizedBox(height: 200,
                    width: double.infinity,
                    child: Carousel(
                      dotSize: 0,
                      dotVerticalPadding: 320,
                      dotBgColor: Colors.transparent,
                      autoplayDuration: Duration(seconds: 12),
                      images: [Image.network(widget.recommendationPlace.image,fit:BoxFit.fill ,)]
                    ),
                  )
                ],
              ),
            ),
            panelBuilder: (controller )
              {ScrollController controllerIn=ScrollController(initialScrollOffset: 0);
              controllerIn=controller;
              return PanelWidget(
                  onScrolledPanel:checkScrolling(controllerIn),
                  recommendationPlace: widget.recommendationPlace,
                  onClickedPanel: checkController,

                );
              }
          ),
          Positioned(
            left: 358,
              top:60,
              child: Column(
                children: [
                  Container(
                    //  margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(

                        color: kPrimaryColor.withAlpha(100),
                        shape: BoxShape.circle
                    ),

                    child: IconButton(
                      icon: Icon(
                          !isBooked?Icons.bookmark_border:Icons.bookmark,
                          size: 35,color: Colors.white),

                      onPressed: () {
                      _toggleBook();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    //  margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(

                        color: kPrimaryColor.withAlpha(100),
                        shape: BoxShape.circle
                    ),

                    child: IconButton(
                      icon: Icon(
                        !isLiked?Icons.favorite_border:Icons.favorite,
                        size: 35,color: Colors.white,),

                      onPressed: () {
                    //    Navigator.pop(context);
                       _toggleLike();
                      },
                    ),
                  ),

                ],
              )


          ),
          Positioned(
            top: 170,
            child: Visibility(
              visible: isLiked&&isSimilarOpened&&!isPanelClosedPlaces,
              child: AnimatedContainer(
                color: Colors.transparent,
                height: 200,
                width: width,
                duration: Duration(milliseconds: 200),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child:IconButton(
                        onPressed: () {
                          _toggleClose();
                        },
                        icon: Icon(Icons.close_rounded,color: Colors.deepOrange, size: 25,),


                      )
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for(int i=0;i<widget.similarPlacesList.length;i++)
                            SimilarPlaceCard(similarPlace: widget.similarPlacesList[i],)

                        ],
                      ),
                    )
                  ],
                ),),

            ),
          )

        ],
      ),
      bottomNavigationBar: BottomNavBar(),

    );
  }

  void _toggleLike() {
    print('pressed');

    setState(() {
      isSimilarOpened=!isSimilarOpened;
      isLiked=!isLiked;
    });
  }
  void _toggleClose() {
    print('pressed');

    setState(() {
      isSimilarOpened=!isSimilarOpened;
     // isLiked=!isLiked;
    });
  }

  void _toggleBook() {
    print('pressed');
    setState(() {
      isBooked=!isBooked;
    });
  }



  void checkController() {
    setState(() {
       panelController.open();
       isPanelClosedPlaces=!isPanelClosedPlaces;
    });
  }
  void _scrollListener() {
    if (controller.position.userScrollDirection == ScrollDirection.reverse) {
      print("hi");
    }
    if (controller.position.userScrollDirection == ScrollDirection.forward) {
      print("hi");
  }}

   checkScrolling(ScrollController controller) {
     if (controller.hasClients)
print("hii scrolling");
  }
}
