import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util_recommendation.dart';
import 'package:graduation_project/models/recommendation_city.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
class CollaborativeModel {
  Future <List<BookmarkPlace>> fetchBookedRestaurants(String plan ) async {
    // print("hiiii");
    String request=ApiUtilRecommendation.GET_ALL_RESTAURANTS_BOOKMARKS(plan);
    http.Response response = await http.get(request);

    List<BookmarkPlace> bookmarkPlaces = [];
    if(response.statusCode == 200){
      List< dynamic> body = jsonDecode(response.body);
      for(var item in body){
        BookmarkPlace place = BookmarkPlace.fromJson(item);

        bookmarkPlaces.add(place);
      }
    }
    List<BookmarkPlace> reversedList = new List.from(bookmarkPlaces.reversed);

    return reversedList;
  }
}
