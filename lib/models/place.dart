import 'package:flutter/cupertino.dart';

class Place {
   String id;
   String name;
   String city;
   String country;
   int rating;
   String location;
   String link;
   String imageId;

  Place(this.id, this.name, this.city, this.country, this.rating, this.location,
      this.link, this.imageId);

  Place.fromJson(Map<String, dynamic> jsonObject){
      this.id = jsonObject['id'].toString();
      this.name = jsonObject['name'].toString();
      this.city = jsonObject['city'].toString();
      this.country = jsonObject['country'].toString();
      this.rating = jsonObject['rating'];
      this.location = jsonObject['location'];
      this.link = jsonObject['link'].toString();
      this.imageId = jsonObject['image_id'].toString();
  }
}


