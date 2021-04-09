class LocationUser{
  double lat;
  double lon;

  LocationUser(this.lat, this.lon);

  LocationUser.fromJson(Map<String, dynamic> jsonObject) {
    this.lat = jsonObject['latitude'];
    this.lon = jsonObject['longitude'];
  }

}