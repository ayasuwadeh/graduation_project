import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';

class BookmarkPlace{
  String id;
  String name;
String city;
String country;

  double rating;
  String source;
  String image;


  BookmarkPlace();

  BookmarkPlace.fromJson(Map<String, dynamic> jsonObject) {
    this.id=jsonObject['id'];
    this.name=jsonObject['name'];
    this.city=jsonObject['city'];
    this.country=jsonObject['country'];

    if((jsonObject['rating'])!=null)
    { this.rating = (jsonObject['rating']/2);//TODO: ROUNDING
    }
    else this.rating=-1;

    this.source=jsonObject['source'];

    if((jsonObject['image'])!=null) {
      this.image = jsonObject['image'];
    }

  }


}