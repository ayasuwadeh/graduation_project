class GeneralLocation{
  String lat;
  String lan;

  GeneralLocation(this.lat, this.lan);

  GeneralLocation.fromJson(Map<String, dynamic> jsonObject) {
    this.lat = jsonObject['latitude'].toString();
    this.lan = jsonObject['longitude'].toString();
  }

}