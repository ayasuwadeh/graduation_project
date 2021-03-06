import 'location.dart';
import 'category.dart';

class CurrencyExchange{
  String id;
  String name;
  Location location;
  Category category;

  CurrencyExchange(this.id, this.name, this.location, this.category);

  CurrencyExchange.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'].toString();
    this.name = jsonObject['name'].toString();
    this.location = Location.fromJson(jsonObject['location']);
    this.category = Category.fromJson(jsonObject['categories'][0]);
  }
}