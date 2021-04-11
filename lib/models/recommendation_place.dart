import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/rest_details.dart';
import 'package:graduation_project/api/restaurant_details.dart';
import 'package:graduation_project/models/general_location.dart';
class RecommendationPlace{
  String id;
  String name;
  GeneralLocation location=GeneralLocation(-100,-200);
  double rating;
  //String googleID;
  String address;
  String phoneNumber;
  String category;
  String description;
  String url;
  String image;
  double score;

  RecommendationPlace(this.id, this.name, );

  RecommendationPlace.fromJson(Map<String, dynamic> jsonObject)  {
    this.id = jsonObject['id'].toString();
    this.name = jsonObject['name'];
    this.location.lat=jsonObject['lat'];
    this.location.lan=jsonObject['lng'];
    this.address=jsonObject['formatted_address'].toString();
    this.phoneNumber='tel:'+jsonObject['phone'].toString();
    this.category=jsonObject['category'];
    this.description=jsonObject['description'];
    this.url=jsonObject['url'];
    this.image=jsonObject['image'];
    if(jsonObject['rate']!=null)
      this.rating=jsonObject['rate'];
    else rating=-1;
    if(jsonObject['score']!=null)
      this.score=jsonObject['score'];

  }

}

