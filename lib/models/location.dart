class Location{
  String address;
  String crossStreet;
  double lat;
  double lan;
  String distance;
  String city;
  String country;
  String formattedAddress;

  Location(this.address, this.crossStreet, this.lat, this.lan,
      this.distance, this.city, this.country, this.formattedAddress);

  Location.fromJson(Map<String, dynamic> jsonObject){
    this.address = jsonObject['address'].toString();
    this.lat = jsonObject['lat'];
    this.lan = jsonObject['lng'];
    this.distance = jsonObject['distance'].toString();
    this.city = jsonObject['city'].toString();
    this.country = jsonObject['country'].toString();
    List addresses = jsonObject['formattedAddress'];
    this.formattedAddress = addresses.join("");
  }
}