import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/foursquare_bookmark_place_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoursquareBookmarkDetails{

  Future<FoursquareDetails> fetchDetails(String venueID) async{

    String request =ApiUtil.HOTEL_RATE(venueID);
    var response = await http.get(request);

    var bookmarkPlaceDetails=new FoursquareDetails();
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      if(body['response']!=null) {
        bookmarkPlaceDetails = FoursquareDetails.fromJson(body['response']['venue']);
      }
    }
    //else print (response.statusCode);

    return bookmarkPlaceDetails;
  }
}

