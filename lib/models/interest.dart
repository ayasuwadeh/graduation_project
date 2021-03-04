class Interest{

  String name;

  Interest(this.name);

  Interest.fromJson(Map<String, dynamic> jsonObject){
    this.name = jsonObject['name'].toString();
  }

}