class Category{
  String name;

  Category(this.name);

  Category.fromJson(Map<String, dynamic> jsonObject){
    this.name = jsonObject['name'].toString();
  }
}