import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';

class HotelDetails{
  double rating;
 // String image;
 // String phoneNumber;

  HotelDetails(this.rating, );

  HotelDetails.fromJson(Map<String, dynamic> jsonObject) {
    this.rating = (jsonObject['rating'].toDouble()/2).round();
    print(rating.toString()+"hereeeeeeee0");
   // this.phoneNumber = jsonObject['contact'].toString();
  }
  // HotelDetails.fromJson1(Map<String, dynamic> jsonObject) {
  //   this.image=jsonObject['prefix']+jsonObject['width']+'x'+jsonObject['height']+jsonObject['suffix'];
  //   // this.phoneNumber = jsonObject['contact'].toString();
  // }


}