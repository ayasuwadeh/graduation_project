import 'package:graduation_project/api/api_util_recommendation.dart';
import 'package:graduation_project/models/rest_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestDetailsSecondApi{

  Future<RestDetails> fetchDetails(String venueID) async{

    String request =ApiUtilRecommendation.GET_GOOGLE_DETAILS(venueID);
    var response = await http.get(request);

    var hotelDetails=new RestDetails();
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      if(body['results'].length>0) {
        hotelDetails = RestDetails.fromJson(body['results'][0]);
        //print(hotelDetails.lat);
      }
      else
        {hotelDetails.lat=-100;
        hotelDetails.lan=-200;
        }
    }
    //else print (response.statusCode);

    return hotelDetails;
  }
}

