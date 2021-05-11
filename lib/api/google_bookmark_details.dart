import 'package:graduation_project/api/api_util_recommendation.dart';
import 'package:graduation_project/models/google_bookmark_place_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleBookmarkDetails{

  Future<GoogleBookmarkPlace> fetchDetails(String venueID) async{

    String request =ApiUtilRecommendation.PLACE_DETAILS_GOOGLE(venueID);
    var response = await http.get(request);

    var bookmarkPlaceDetails=new GoogleBookmarkPlace();
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      if(body['result']!=null) {
        bookmarkPlaceDetails = GoogleBookmarkPlace.fromJson(body['result']);
      }
    }
    //else print (response.statusCode);

    return bookmarkPlaceDetails;
  }
}

