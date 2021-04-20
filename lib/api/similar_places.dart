import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util_recommendation.dart';
import 'package:graduation_project/models/recommendation_place.dart';
import 'package:graduation_project/models/rest_details.dart';
class SimilarPlacesRecommendationApi {
  Future <List<RecommendationPlace>> getData( String placeId) async {
    String request=ApiUtilRecommendation.GET_ALL_SIMILAR_PLACES(placeId);
    http.Response response = await http.get(request);

    List<RecommendationPlace> places = [];

    if(response.statusCode == 200){
      List< dynamic> body = jsonDecode(response.body);
      for(var item in body){
        RecommendationPlace place = RecommendationPlace.fromJson(item);

        places.add(place);
        print(place.location.lat);
      }
      print(places.length);
    }
    else print(response.statusCode);

    return places;
  }
}
