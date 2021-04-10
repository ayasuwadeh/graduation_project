class GeneralLocation{
  double lat;
  double lan;

  GeneralLocation(this.lat, this.lan);

  GeneralLocation.fromJson(Map<String, dynamic> jsonObject) {
    this.lat = jsonObject['latitude'];
    this.lan = jsonObject['longitude'];
  }

}