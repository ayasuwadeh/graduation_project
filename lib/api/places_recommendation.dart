import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util_recommendation.dart';
import 'package:graduation_project/models/recommendation_place.dart';
import 'package:graduation_project/models/entertainment.dart';
import 'package:graduation_project/services/auth_provider.dart';
class PlacesRecommendationApi {
  Future <List<RecommendationPlace>> getData( ) async {
    List<String> cuisines=[];
    String userCuisines='';
    Entertainment temp=new Entertainment();
    AuthProvider authProvider=new AuthProvider();
    Map<String, dynamic> responseData= await authProvider.findUserInterests();
    for(var item in responseData['data'])
    {
      for(var innerItem in item)
        {
          temp=Entertainment.fromJson(innerItem);
          cuisines.add(temp.name);

        }
    }
    if(cuisines.length==0)
      userCuisines='';
    else if(cuisines.length==1)
      userCuisines=cuisines[0].toString();
    else userCuisines=userCuisines=cuisines.join(', ');

    String request=ApiUtilRecommendation.GET_ALL_PLACES_RECOMMENDATION( userCuisines);
    http.Response response = await http.get(request);

    List<RecommendationPlace> places = [];

    if(response.statusCode == 200){
      List< dynamic> body = jsonDecode(response.body);
      for(var item in body){
        RecommendationPlace place = RecommendationPlace.fromJson(item);

        places.add(place);
        //print(place.location.lat);
      }
      //print(places.length);
    }
    //else print(response.statusCode);

    return places;
  }
}
