import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util_recommendation.dart';
import 'package:graduation_project/models/restaurant.dart';
import 'package:graduation_project/models/cuisine.dart';
import 'package:graduation_project/services/auth_provider.dart';
class RestsRecommendationApi {
   Future <List<Restaurant>> getData( ) async {
    List<String> cuisines=[];
    String userCuisines='';
    Cuisine temp=new Cuisine();
    AuthProvider authProvider=new AuthProvider();
    Map<String, dynamic> responseData= await authProvider.findUserCuisines();
    for(var item in responseData['data'])
       {
         temp=Cuisine.fromJson(item);
         cuisines.add(temp.name);
       }
    if(cuisines.length==0)
      userCuisines='';
    else if(cuisines.length==1)
      userCuisines=cuisines[0].toString();
    else userCuisines=userCuisines=cuisines.join(', ');

    String request=ApiUtilRecommendation.GET_ALL_RESTAURANTS_RECOMMENDATION(userCuisines);
    http.Response response = await http.get(request);

    List<Restaurant> rests = [];

    if(response.statusCode == 200){
      List< dynamic> body = jsonDecode(response.body);
      for(var item in body){
        Restaurant rest = Restaurant.fromJson(item);

        rests.add(rest);
        //print(rest.location.lat);
      }
       //print(rests.length);
    }
    //else print(response.statusCode);

     return rests;
  }

}
