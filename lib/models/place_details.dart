import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';

class PlaceDetails{
  double rating;
  String description;
  List <String> images= List<String>();
   String phoneNumber;
   String url;
   String isOpen;

  PlaceDetails(this.rating, );

  PlaceDetails.fromJson(Map<String, dynamic> jsonObject) {
    if((jsonObject['rating'])!=null)
    { this.rating = (jsonObject['rating']/2);//TODO: ROUNDING
      print(this.rating.toString()+"  ratinggggggg0");
    }
    else this.rating=-1;

    if(jsonObject['description']!=null)
    this.description=jsonObject['description'];

    else this.description='a gallery';

    if((jsonObject['photos']['count'])!=0) {
      for (var image in jsonObject['photos']['groups'][0]['items'])
       {
         this.images.add(image['prefix'].toString() +
             image['width'].toString() +
             'x' + image['height'].toString() +
             image['suffix'].toString());}
    }

    else this.images=['not found'];

    if(jsonObject['url']!=null)
      this.url=jsonObject['url'];
    else this.url='not found';

   if(jsonObject['contact']['phone']!=null)
     this.phoneNumber='tel:'+jsonObject['contact']['phone'];
   else this.phoneNumber='tel:0';

   if(jsonObject['hours']!=null)
    if(jsonObject['hours']['status']!=null)
      this.isOpen=jsonObject['hours']['status'];
    else this.isOpen=' ';
    else this.isOpen=' ';


  }



}