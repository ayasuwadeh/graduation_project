import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/place_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceDetailsApi{

  Future<PlaceDetails> fetchDetails(String venueID) async{
    String details = ApiUtil.HOTEL_RATE(venueID);

    var response = await http.get(details);

    var hotelDetails=new PlaceDetails(0);
    print(venueID);
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      // print("in ratingggg");
      hotelDetails = PlaceDetails.fromJson(body['response']['venue']);
    }
    else print (response.statusCode);

    return hotelDetails;
  }
}