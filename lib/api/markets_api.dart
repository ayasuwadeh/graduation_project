import 'dart:convert';
import 'package:graduation_project/models/market.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';

class MarketsApi{
  Future<List<Market>> fetchAllMarkets() async{
    // TODO make location dynamic
    String allMarkets = ApiUtil.ALL_MARKETS('48.85177', '2.22139');

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