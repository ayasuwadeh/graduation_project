import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util_recommendation.dart';
import 'package:graduation_project/models/recommendation_place.dart';
import 'package:graduation_project/models/rest_details.dart';
class PlacesRecommendationApi {
  Future <List<RecommendationPlace>> getData( ) async {
    String request=ApiUtilRecommendation.GET_ALL_PLACES_RECOMMENDATION('fast food');
    http.Response response = await http.get(request);

    List<RecommendationPlace> rests = [];

    if(response.statusCode == 200){
      List< dynamic> body = jsonDecode(response.body);
      for(var item in body){
        RecommendationPlace place = RecommendationPlace.fromJson(item);

        rests.add(place);
        print(place.location.lat);
      }
      print(rests.length);
    }
    else print(response.statusCode);

    return rests;
  }
}
