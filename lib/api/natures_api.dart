import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/interest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NatureApi{


  Future<List<Interest>> fetchAllNatures() async{
    String allNatures = ApiUtil.MAIN_API_UTIL + ApiUtil.ALL_NATURES;

    Map<String, String> headers = {
      'accept' : 'application/json'
    };

    var response = await http.get(allNatures, headers: headers);

    List<Interest> natures = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      for(var item in body['data']){
        Interest nature = Interest.fromJson(item);
        natures.add(nature);
      }
    }
    return natures;
  }
}