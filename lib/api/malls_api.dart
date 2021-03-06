import 'dart:convert';
import 'package:graduation_project/models/shopping_mall.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';

class MallsApi{
  Future<List<ShoppingMall>> fetchAllMalls() async{
    // TODO make location dynamic
    String allMalls = ApiUtil.ALL_MALLS('40.7099', '-73.9622');

    //print(allMalls);
    var response = await http.get(allMalls);

    List<ShoppingMall> malls = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      for(var item in body['response']['venues']){
        ShoppingMall mall = ShoppingMall.fromJson(item);
        malls.add(mall);
      }
    }
    return malls;
  }
}