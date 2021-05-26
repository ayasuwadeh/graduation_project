
class Cuisine{
  String name;

  Cuisine();

  Cuisine.fromJson(Map<String, dynamic> jsonObject){
    this.name = jsonObject['name'].toString();
  }
}