import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/hotel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HotelApi{

  Future<List<Hotel>> fetchAllHotels() async{
    // TODO make location dynamic
    String allMarkets = ApiUtil.ALL_HOTELS('40.7099', '-73.9622');

    var response = await http.get(allMarkets);

    List<Hotel> hotels = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      for(var item in body['response']['venues']){
        Hotel hotel = Hotel.fromJson(item);
        hotels.add(hotel);
      }
     // print(hotels.length);
    }
    else print(response.statusCode);
    return hotels;
  }
}