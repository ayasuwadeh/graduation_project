import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/hotel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
class HotelApi{

  Future<List<Hotel>> fetchAllHotels() async{
    Position position;

    position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    String allMarkets = ApiUtil.ALL_HOTELS(position.latitude.toString(),position.longitude.toString());

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