import 'package:graduation_project/api/api_util_recommendation.dart';
import 'package:graduation_project/models/inner_restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestInnerDetails{

  Future<InnerRest> fetchMoreDetails(String id) async{

    String request =ApiUtilRecommendation.PLACE_DETAILS_GOOGLE(id);
    var response = await http.get(request);

    var innerDetails=new InnerRest();
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      if(body['result']!=null) {
        innerDetails = await InnerRest.fetchImages(body['result']);
      }
      else
      {

      }
    }
    //else print (response.statusCode);

    return innerDetails;
  }
}

