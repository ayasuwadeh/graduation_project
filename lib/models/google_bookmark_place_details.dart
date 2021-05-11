import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/general_location.dart';

class GoogleBookmarkPlace{
  GeneralLocation location=new GeneralLocation((-200).toString(),(-200).toString());
  List <String> images=List<String>();
  List <String> imageReferences=List<String>();
  bool isOpen=false;
  int priceLevel=-1;
  String phoneNumber='';


  GoogleBookmarkPlace();

  GoogleBookmarkPlace.fromJson(Map<String, dynamic> jsonObject) {
    int i=0;

    this.location.lat=jsonObject['geometry']['location']['lat'].toString();
    // print('hellonn');

    this.location.lan=jsonObject['geometry']['location']['lng'].toString();
    if(jsonObject['opening_hours']!=null)
      if(jsonObject['opening_hours']['open_now']!=null)
        this.isOpen=jsonObject['opening_hours']['open_now'];

    if(jsonObject['price_level']!=null)
      this.priceLevel=jsonObject['price_level'];

    if(jsonObject['formatted_phone_number']!=null)
      this.phoneNumber='tel:'+jsonObject['formatted_phone_number'];
    else this.phoneNumber='tel:0';


    if(jsonObject['photos']!=null)
      if(jsonObject['photos'].length>0)
    for( var item in jsonObject['photos'])
        { i++;
        if(i<6)
        {
          this.imageReferences.add(item['photo_reference']);
          this.images.add("https://maps.googleapis.com/maps/api/place/photo?maxwidth=450&maxheight=1000&photoreference="+item['photo_reference']+"&key=AIzaSyDA6EANtFodVUNO5AJXKL0m4xyTT3FJvec");
          // print(item['photo_reference']);
        }
        }



  }


}