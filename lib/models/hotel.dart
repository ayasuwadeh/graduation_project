import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';

class Hotel{
  String id;
  String name;
  Location location;
  Category category;

  Hotel(this.id, this.name, this.location, this.category);

  Hotel.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'].toString();
    this.name = jsonObject['name'].toString();
    this.location = Location.fromJson(jsonObject['location']);
    this.category = Category.fromJson(jsonObject['categories'][0]);
  }
}