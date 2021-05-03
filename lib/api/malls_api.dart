import 'dart:convert';
import 'package:graduation_project/models/shopping_mall.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';
import 'package:geolocator/geolocator.dart';
class MallsApi{
  Future<List<ShoppingMall>> fetchAllMalls() async{
    Position position;

    position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    String allMalls = ApiUtil.ALL_MALLS(position.latitude.toString(), position.longitude.toString());

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