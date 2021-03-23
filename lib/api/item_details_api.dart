import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/item_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemDetailsApi{

  Future<ItemDetails> fetchDetails(String venueID) async{
    String details = ApiUtil.HOTEL_RATE(venueID);

    var response = await http.get(details);

    var hotelDetails=new ItemDetails(0);
    print(venueID);
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
     // print("in ratingggg");
         hotelDetails = ItemDetails.fromJson(body['response']['venue']);
    }
    else print (response.statusCode);

    return hotelDetails;
  }
}