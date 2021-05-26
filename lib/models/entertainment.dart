
class Entertainment{
  String name;

  Entertainment();

  Entertainment.fromJson(Map<String, dynamic> jsonObject){
    this.name = jsonObject['name'].toString();
  }
}