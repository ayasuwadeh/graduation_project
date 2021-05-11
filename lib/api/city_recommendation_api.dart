import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util_recommendation.dart';
import 'package:graduation_project/models/recommendation_city.dart';
import 'package:graduation_project/models/rest_details.dart';
class CityRecommendationApi {
  Future <List<RecommendationCity>> fetchCities(String plan ) async {
    // print("hiiii");
    String request=ApiUtilRecommendation.GET_ALL_CITIES_RECOMMENDATION(plan);
    http.Response response = await http.get(request);

    List<RecommendationCity> places = [];

    if(response.statusCode == 200){
      List< dynamic> body = jsonDecode(response.body);
      for(var item in body){
        RecommendationCity place = RecommendationCity.fromJson(item);

        places.add(place);
       // print(place.name);
      }
    }

    return places;
  }
}
