import 'api_util_recommendation.dart';
import 'package:http/http.dart' as http;

class ApiUtilOCR {

Future <String> findTexts(String path) async {
 String request= ApiUtilRecommendation.fetchTexts(path);

 var response = await http.get(request);

 String back='';
 if(response.statusCode == 200){
   String body = response.body;
   back=body;
 }
return back;
}

}
