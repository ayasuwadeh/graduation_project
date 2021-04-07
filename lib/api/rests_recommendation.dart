import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util_recommendation.dart';
import 'package:graduation_project/models/restaurant.dart';
import 'package:graduation_project/models/rest_details.dart';
class RestsRecommendationApi {
   Future <List<Restaurant>> getData( ) async {
    String request=ApiUtilRecommendation.GET_ALL_RESTAURANTS_RECOMMENDATION('fast food');
    http.Response response = await http.get(request);

    List<Restaurant> rests = [];

    if(response.statusCode == 200){
      List< dynamic> body = jsonDecode(response.body);
      for(var item in body){
        Restaurant rest = Restaurant.fromJson(item);

        rests.add(rest);
        print(rest.location.lat);
      }
       print(rests.length);
    }
    else print(response.statusCode);

     return rests;
  }
}
