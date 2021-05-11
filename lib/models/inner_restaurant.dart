import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';
class InnerRest{
  List <String> images=List<String>();
  List <String> imageReferences=List<String>();
  bool isOpen=false;
  int priceLevel=-1;
  String phoneNumber='';


  InnerRest( );

  static Future <InnerRest>fetchImages(Map<String, dynamic> jsonObject) async {
    InnerRest innerRest=InnerRest();
    int i=0;
    if(jsonObject['opening_hours']!=null)
      if(jsonObject['opening_hours']['open_now']!=null)
        innerRest.isOpen=jsonObject['opening_hours']['open_now'];

    if(jsonObject['price_level']!=null)
      innerRest.priceLevel=jsonObject['price_level'];

    if(jsonObject['formatted_phone_number']!=null)
      innerRest.phoneNumber='tel:'+jsonObject['formatted_phone_number'];
    else innerRest.phoneNumber='tel:0';


    if(jsonObject['photos']!=null)
      if(jsonObject['photos'].length>0)
        for( var item in jsonObject['photos'])
          { i++;
            if(i<6)
           {
             innerRest.imageReferences.add(item['photo_reference']);
            innerRest.images.add("https://maps.googleapis.com/maps/api/place/photo?maxwidth=450&maxheight=1000&photoreference="+item['photo_reference']+"&key=AIzaSyDA6EANtFodVUNO5AJXKL0m4xyTT3FJvec");
            // print(item['photo_reference']);
           }
          }
          //innerRest.imageReferences.add(item['photo_reference']);

    return innerRest;
  }


}