import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/rest_details.dart';
import 'package:graduation_project/api/restaurant_details.dart';
import 'package:graduation_project/models/general_location.dart';
class Restaurant{
  String id;
  String name;
  double rating;
  String googleID;
  GeneralLocation location=GeneralLocation((-100).toString(),(-200).toString());
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
  this.location.lat=rest.lat.toString();
  this.location.lan=rest.lan.toString();
  this.googleID=rest.id;



  }
}

