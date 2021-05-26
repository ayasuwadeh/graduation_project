import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/foursquare_details/widget/panel_widget.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/api/foursquare_bookmark_details.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
import 'package:graduation_project/models/foursquare_bookmark_place_details.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
import 'package:graduation_project/services/auth_provider.dart';
class PlaceWidgetFoursquare extends StatelessWidget {
  BookmarkPlace place;
  PlaceWidgetFoursquare(this.place);
  FoursquareDetails placeDetails;
  FoursquareBookmarkDetails placeDetailsApi = FoursquareBookmarkDetails();


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
                  {
                  placeDetails=snapshot.data;
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
  FoursquareDetails placeDetails;
  BookmarkPlace place;
  MainPage(this.placeDetails,this.place);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final panelController = PanelController();
  bool isBooked=false;
  bool isLiked=false;
  AuthProvider authProvider=new AuthProvider();

  @override
  void initState() {
    updateBookmark();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,

        leading: IconButton(icon:Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context,isBooked);
          },),
        backgroundColor: Colors.transparent,
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
            body: widget.place.image!='not found'?

            Image(

                 image: NetworkImage(widget.place.image,),fit: BoxFit.cover,):
            [NetworkImage('https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg')],



            panelBuilder: (ScrollController scrollController)=>PanelWidget(
              place: widget.place,
              placeDetails: widget.placeDetails,
              onClickedPanel: panelController.open,

            ),
          ),
          Positioned(
            left: 358,
              top:70,
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

    setState(() {
      isLiked=!isLiked;
    });
  }

  void _toggleBook() {
    if(!isBooked)
    {
      authProvider.addEntertainmentBookmark(place:widget.place );
    }

    if(isBooked)
      {
        authProvider.deleteEntertainmentBookmark(id: widget.place.id) ;

      }

    setState(() {
      isBooked=!isBooked;
    });
  }
  void updateBookmark() async{
    bool d=await authProvider.findEntertainmentBookmark(id:widget.place.id);
    setState(() {
      isBooked=d;
    });
  }

  }


