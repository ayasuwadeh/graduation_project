import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';

class ItemDetails{
  double rating;
  String image;
  String url;
  double lat;
  double lan;
 // String phoneNumber;

  ItemDetails(this.rating, );

  ItemDetails.fromJson(Map<String, dynamic> jsonObject) {
    if((jsonObject['rating'])!=null)
   { this.rating = (jsonObject['rating']/2);//TODO: ROUNDING
     //print(this.rating.toString()+"  ratinggggggg0");
     }
    else this.rating=-1;

    if((jsonObject['bestPhoto'])!=null) {
      this.image = jsonObject['bestPhoto']['prefix'] +
          jsonObject['bestPhoto']['width'].toString() +
          'x' + jsonObject['bestPhoto']['height'].toString() +
          jsonObject['bestPhoto']['suffix'];
    }
     else this.image='not found';
     if(jsonObject['url']!=null)
     this.url=jsonObject['url'];
     else this.url='not found';

    this.lat=jsonObject['location']['lat'];
    this.lan=jsonObject['location']['lng'];

  }


}