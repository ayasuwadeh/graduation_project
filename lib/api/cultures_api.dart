import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/interest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CultureApi{

  Future<List<Interest>> fetchAllCultures() async{
    String allCultures = ApiUtil.MAIN_API_UTIL + ApiUtil.ALL_CULTURES;

    Map<String, String> headers = {
      'accept' : 'application/json'
    };

    var response = await http.get(allCultures, headers: headers);

    List<Interest> cultures = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      for(var item in body['data']){
        Interest culture = Interest.fromJson(item);
        cultures.add(culture);
      }
    }
    return cultures;
  }
}