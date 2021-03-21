class LocationUser{
  String lat;
  String lon;

  LocationUser(this.lat, this.lon);

  LocationUser.fromJson(Map<String, dynamic> jsonObject) {
    this.lat = jsonObject['latitude'].toString();
    this.lon = jsonObject['longitude'].toString();
  }

}