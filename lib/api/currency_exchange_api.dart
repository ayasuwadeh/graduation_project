import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/currency_exchange.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyExchangeApi{
  //'40.7099', '-73.9622'
  Future<List<CurrencyExchange>> fetchAllCurrencyExchange() async{
    //TODO : make location dynamic
    String allCurrencyExchange = ApiUtil.ALL_CURRENCY_EXCHANGE('48.85177', '2.22139');

    //print(allHospitals);
    var response = await http.get(allCurrencyExchange);

    List<CurrencyExchange> currencyExchanges = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      //print(body['response']['venues']);
      for(var item in body['response']['venues']){
        CurrencyExchange currencyExchange = CurrencyExchange.fromJson(item);
        currencyExchanges.add(currencyExchange);
      }
    }
    return currencyExchanges;
  }
}