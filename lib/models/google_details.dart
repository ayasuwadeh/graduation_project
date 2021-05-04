import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';

class FoursquareDetails{
  String id;
  String name;
  Location location;
  double rating;
  List <String> images= List<String>();
  String description;
  String url;
  String phoneNumber;

  FoursquareDetails( );

  FoursquareDetails.fromJson(Map<String, dynamic> jsonObject) {
    this.id=jsonObject['place_id'].toString();
    this.name=jsonObject['name'].toString();
    this.location = Location.fromJson(jsonObject['location']);

    if((jsonObject['rating'])!=null)
    { this.rating = (jsonObject['rating']/2);//TODO: ROUNDING
    }
    else this.rating=-1;

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

    if(jsonObject['description']!=null)
      this.description=jsonObject['description'];

    else this.description='a gallery';



  }


}