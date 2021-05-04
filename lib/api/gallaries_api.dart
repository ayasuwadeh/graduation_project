import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/gallary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
class GalleryApi{

  Future<List<Gallery>> fetchAllGalleries(int index) async{
    String allGalleries ='';
    Position position;

    position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);


    switch (index)
    {
      case 0:
        {allGalleries=ApiUtil.GALLARIES(position.latitude.toString(),position.longitude.toString());
        }
        break;
      case 1:
        {allGalleries=ApiUtil.ZOOS(position.latitude.toString(),position.longitude.toString());
        }
        break;
      case 2:
        {allGalleries=ApiUtil.PARKS(position.latitude.toString(),position.longitude.toString());
        }
        break;
      case 3:
        {allGalleries=ApiUtil.MUSEUM(position.latitude.toString(),position.longitude.toString());
        }
        break;
      case 4:
        {allGalleries=ApiUtil.BEACH(position.latitude.toString(),position.longitude.toString());
        }
        break;



    }

    //print(allHospitals);
    var response = await http.get(allGalleries);

    List<Gallery> galleries = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      //print(body['response']['venues']);
      for(var item in body['response']['venues']){
        Gallery gallery = Gallery.fromJson(item);
        galleries.add(gallery);
      }
    }
    return galleries;
  }
}