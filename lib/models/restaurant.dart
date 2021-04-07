import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/rest_details.dart';
import 'package:graduation_project/api/rest_details_second.dart';
import 'package:graduation_project/models/rest_location.dart';
class Restaurant{
  String id;
  String name;
  double rating;
  String googleID;
  RestLocation location=RestLocation(-100,-200);
  double score;
  String cus;
  Restaurant(this.id, this.name, );

  Restaurant.fromJson(Map<String, dynamic> jsonObject)  {
    this.id = jsonObject['id'].toString();
    this.name = jsonObject['name'].toString();
    if(jsonObject['rating']!=null)
      this.rating=jsonObject['rating'];
    else rating=-1;
    this.score=jsonObject['score'];
    this.cus=jsonObject['description'];
    fetchDetailsFromHere();

  }

  Future fetchDetailsFromHere() async
  {    RestDetailsSecondApi detailsApi=RestDetailsSecondApi();

  RestDetails rest= await detailsApi.fetchDetails(this.name);
  this.location.lat=rest.lat;
  this.location.lan=rest.lan;
  this.googleID=rest.id;



  }
}

