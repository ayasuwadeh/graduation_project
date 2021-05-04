import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';

class RestDetails{
  double lat;
  double lan;
  String id;

  RestDetails( );

  RestDetails.fromJson(Map<String, dynamic> jsonObject) {
    this.lat=jsonObject['geometry']['location']['lat'];
    this.lan=jsonObject['geometry']['location']['lng'];
    this.id=jsonObject['place_id'];

  }


}