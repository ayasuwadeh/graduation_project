import 'dart:convert';
import 'package:graduation_project/models/market.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';
import 'package:geolocator/geolocator.dart';
class MarketsApi{
  Future<List<Market>> fetchAllMarkets() async{
    Position position;

    position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    String allMarkets = ApiUtil.ALL_MARKETS(position.latitude.toString(), position.longitude.toString());

    //print(allMalls);
    var response = await http.get(allMarkets);

    List<Market> markets = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      for(var item in body['response']['venues']){
        Market market = Market.fromJson(item);
        markets.add(market);
      }
    }
    return markets;
  }
}