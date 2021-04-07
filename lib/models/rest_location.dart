class RestLocation{
  double lat;
  double lan;

  RestLocation(this.lat, this.lan);

  RestLocation.fromJson(Map<String, dynamic> jsonObject) {
    this.lat = jsonObject['latitude'];
    this.lan = jsonObject['longitude'];
  }

}