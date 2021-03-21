
import 'package:graduation_project/api/api_util.dart';
import 'package:http/http.dart' as http;

class UserTokenApi{

  Future <String> getUserToken(Map creds) async{
    String tokenApi = ApiUtil.MAIN_API_UTIL + '/sanctum/token';

    Map <String, String> headers = {
      'accept' : 'application/json'
    };

    var response = await http.post(tokenApi, headers: headers, body: creds);

    print(response.body.toString());
  }
}