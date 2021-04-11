import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';

class RestDetails{
  //double rating;
  //String image;
  // String url;
  String id;

  RestDetails( );

  RestDetails.fromJson(Map<String, dynamic> jsonObject) {
    this.id=jsonObject['place_id'];

  }


}