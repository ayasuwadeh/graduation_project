import 'package:flutter/cupertino.dart';
import 'package:graduation_project/Screens/Home/selection_title.dart';
import 'package:graduation_project/components/place_card.dart';
import 'restaurant_card.dart';
import '../../constants.dart';
import 'package:graduation_project/models/restaurant.dart';
import 'package:graduation_project/api/restaurant_recommendation.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:flutter/material.dart';
class Restaurants extends StatelessWidget {
  List<Restaurant> restaurants= new List<Restaurant>();

  RestsRecommendationApi restApi = RestsRecommendationApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: restApi.getData(),
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
                restaurants=snapshot.data;
               // galleries.sort((a, b) => a.location.distance.compareTo(b.location.distance));
                return RestaurantsCards(restaurants);
                }
              }
          }
          return Container(color: Colors.white,);
        }
    );
  }
}


class RestaurantsCards extends StatefulWidget {
  List<Restaurant> restaurants= new List<Restaurant>();
  RestaurantsCards(this.restaurants);

  @override
  _RestaurantsCardsState createState() => _RestaurantsCardsState();
}

class _RestaurantsCardsState extends State<RestaurantsCards> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        SelectionTitle(
          text: "Restaurants recommended for you",
          press: (){},
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
             children: [
               for(int i=0;i<widget.restaurants.length;i++)
                     widget.restaurants[i].location.lat!=-0.0?RestCard(widget.restaurants[i])
                         :Container()

             ],
          ),
        ),
      ],
    );
  }
}
