class Location{
  String address;
  String crossStreet;
  String lat;
  String lan;
  String distance;
  String city;
  String country;
  String formattedAddress;

  Location(this.address, this.crossStreet, this.lat, this.lan,
      this.distance, this.city, this.country, this.formattedAddress);

  Location.fromJson(Map<String, dynamic> jsonObject){
    this.address = jsonObject['address'].toString();
    this.lat = jsonObject['lat'].toString();
    this.lan = jsonObject['lan'].toString();
    this.distance = jsonObject['distance'].toString();
    this.city = jsonObject['city'].toString();
    this.country = jsonObject['country'].toString();
    List addresses = jsonObject['formattedAddress'];
    this.formattedAddress = addresses.join("");
  }
}