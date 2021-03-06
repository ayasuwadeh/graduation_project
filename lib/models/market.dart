import 'location.dart';
import 'category.dart';

class Market{
  String id;
  String name;
  Location location;
  Category category;

  Market(this.id, this.name, this.location, this.category);

  Market.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'].toString();
    this.name = jsonObject['name'].toString();
    this.location = Location.fromJson(jsonObject['location']);
    this.category = Category.fromJson(jsonObject['categories'][0]);
  }
}