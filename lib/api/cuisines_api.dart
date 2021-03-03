import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/interest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CuisineApi{

  Future<List<Interest>> fetchAllCuisines() async{
    String allCuisines = ApiUtil.MAIN_API_UTIL + ApiUtil.ALL_CUISINES;

    Map<String, String> headers = {
      'accept' : 'application/json'
    };

    var response = await http.get(allCuisines, headers: headers);

    List<Interest> cuisines = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      for(var item in body['data']){
        Interest cuisine = Interest.fromJson(item);
        cuisines.add(cuisine);
      }
    }
    return cuisines;
  }
}