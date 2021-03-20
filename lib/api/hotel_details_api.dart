import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/hotel_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HotelDetailsApi{

  Future<HotelDetails> fetchDetails(String venueID) async{
    String details = ApiUtil.HOTEL_RATE(venueID);
    // String image = ApiUtil.HOTEL_IMAGE(venueID);

    var response = await http.get(details);
    // var imageResponse = await http.get(image);

    HotelDetails hotelDetails=new HotelDetails(0);
    print(venueID);
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
         hotelDetails = HotelDetails.fromJson(body['response']['venue']);
    }

    else hotelDetails.rating=1;
    // if(imageResponse.statusCode == 200){
    //   Map<String, dynamic> body = jsonDecode(imageResponse.body);
    //   hotelDetails = HotelDetails.fromJson1(body['response']['photos']['items']);
    // }

    return hotelDetails;
  }
}