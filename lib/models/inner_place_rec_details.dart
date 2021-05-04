import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/location.dart';
class InnerPlaceRec{
  List <String> imageReferences=List<String>();
  bool isOpen=false;


  InnerPlaceRec( );

  static Future <InnerPlaceRec>fetchImages(Map<String, dynamic> jsonObject) async {
    InnerPlaceRec innerRest=InnerPlaceRec();
    int i=0;
    if(jsonObject['opening_hours']!=null)
      if(jsonObject['opening_hours']['open_now']!=null)
        innerRest.isOpen=jsonObject['opening_hours']['open_now'];


    if(jsonObject['photos']!=null)
      if(jsonObject['photos'].length>0)
        for( var item in jsonObject['photos'])
        { i++;
        if(i<6)
        {
          innerRest.imageReferences.add("https://maps.googleapis.com/maps/api/place/photo?maxwidth=450&maxheight=1000&photoreference="+item['photo_reference']+"&key=AIzaSyD0r9-PDf_iRZH1Kkf6LqyuSnUkw1bJBJ8");
          print(item['photo_reference']);}
        }
    //innerRest.imageReferences.add(item['photo_reference']);

    return innerRest;
  }


}