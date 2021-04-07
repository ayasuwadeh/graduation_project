import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Details/widget/panel_widget.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/api/places_api.dart';
import 'package:graduation_project/models/place_details.dart';
import 'package:graduation_project/models/gallary.dart';
class PlaceWidget extends StatelessWidget {
  Gallery place;
  PlaceWidget(this.place);
  PlaceDetails placeDetails;
  PlaceDetailsApi placeDetailsApi = PlaceDetailsApi();

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
          future: placeDetailsApi.fetchDetails(place.id),
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
                  placeDetails=snapshot.data;
                  print("kkkk");
                  return MainPage(placeDetails,place);
                  }
                }
            }
            return Container(color: Colors.white,);
          }
      );

  }
}

class MainPage extends StatefulWidget {
  PlaceDetails placeDetails;
  Gallery gallery;
  MainPage(this.placeDetails,this.gallery);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 // final place = widget.placeDetails;
  final panelController = PanelController();
  bool isBooked=false;
  bool isLiked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Column(
        //   children: [
        //     Container(
        //     //  margin: EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //
        //           color: kPrimaryColor.withAlpha(100),
        //           shape: BoxShape.circle
        //       ),
        //
        //       child: IconButton(
        //         icon: Icon(Icons.bookmark_border,size: 35,),
        //         onPressed: () {},
        //       ),
        //     ),
        //   ],
        // ),
        // actions: [
        //   Container(
        //   //  margin: EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //
        //         color: kPrimaryColor.withAlpha(100),
        //         shape: BoxShape.circle
        //     ),
        //
        //     child: IconButton(
        //       icon: Icon(Icons.close, size: 35,),
        //
        //       onPressed: () {
        //         Navigator.pop(context);
        //
        //       },
        //     ),
        //   )
        // ],
      ),
      body: Stack(
        children: [
          SlidingUpPanel(
            backdropColor: Colors.transparent,
            maxHeight: 400,
            minHeight: 150,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            controller: panelController,
            color: Colors.transparent,

            body:PageView(
              children: [
                SizedBox(height: 480,
                  width: double.infinity,
                  child: Carousel(
                    dotSize: 5,
                    dotVerticalPadding: 220,
                    dotBgColor: Colors.transparent,
                    autoplayDuration: Duration(seconds: 12),
                    images: widget.placeDetails.images[0]!='not found'?
                    widget.placeDetails.images.map((e)
                    => NetworkImage(e)).toList():
                    [NetworkImage('https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg')],
                  ),
                )
              ],
            ),
            panelBuilder: (ScrollController scrollController)=>PanelWidget(
              gallery: widget.gallery,
              place: widget.placeDetails,
              onClickedPanel: panelController.open,

            ),
          ),
          Positioned(
            left: 358,
              top:50,
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
                  )


                ],
              )


          ),

        ],
      ),
      bottomNavigationBar: BottomNavBar(),

    );
  }

  void _toggleLike() {
    print('pressed');

    setState(() {
      isLiked=!isLiked;
    });
  }

  void _toggleBook() {
    print('pressed');
    setState(() {
      isBooked=!isBooked;
    });
  }


}
