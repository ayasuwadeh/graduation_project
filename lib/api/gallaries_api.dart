import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/gallary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryApi{

  Future<List<Gallery>> fetchAllGalleries(int index) async{
    //TODO : make location dynamic
    String allGalleries ='';
    switch (index)
    {
      case 0:
        {allGalleries=ApiUtil.GALLARIES('40.7099', '-73.9622');
        }
        break;
      case 1:
        {allGalleries=ApiUtil.ZOOS('40.7099', '-73.9622');
        }
        break;
      case 2:
        {allGalleries=ApiUtil.PARKS('40.7099', '-73.9622');
        }
        break;
      case 3:
        {allGalleries=ApiUtil.MUSEUM('40.7099', '-73.9622');
        }
        break;
      case 4:
        {allGalleries=ApiUtil.BEACH('40.7099', '-73.9622');
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
        Gallery hospital = Gallery.fromJson(item);
        galleries.add(hospital);
      }
    }
    return galleries;
  }
}