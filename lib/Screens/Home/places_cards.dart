import 'package:flutter/cupertino.dart';
import 'package:graduation_project/Screens/Home/selection_title.dart';
import 'package:graduation_project/models/recommendation_place.dart';
// import 'package:graduation_project/components/place_card.dart';
import 'package:graduation_project/api/places_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/Screens/Home/place_card.dart';
class Places extends StatelessWidget {
  List<RecommendationPlace> places= new List<RecommendationPlace>();

  PlacesRecommendationApi placesRecommendationApi = PlacesRecommendationApi();

  @override
  Widget build(BuildContext context) {
    //return RestaurantsCards(galleries);

    return FutureBuilder(
        future: placesRecommendationApi.getData(),
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
                places=snapshot.data;
                // galleries.sort((a, b) => a.location.distance.compareTo(b.location.distance));
                return PlacesCards(places);
                }
              }
          }
          return Container(color: Colors.white,);
        }
    );
  }
}


class PlacesCards extends StatefulWidget {
  List<RecommendationPlace> places= new List<RecommendationPlace>();
  PlacesCards(this.places);

  @override
  _PlacesCardsState createState() => _PlacesCardsState();
}

class _PlacesCardsState extends State<PlacesCards> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        SelectionTitle(
          text: "Places recommended for you",
          press: (){},
        ),
        SingleChildScrollView(

          scrollDirection: Axis.horizontal,
          child: Row(

            children: [
              for(int i=0;i<widget.places.length;i++)
                widget.places[i].location.lat!=-0.0?RestCard(widget.places[i])
                    :Container()
            ],
          ),
        ),
      ],
    );
  }
}
