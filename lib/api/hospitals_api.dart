import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/hospital.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
class HospitalApi{

  Future<List<Hospital>> fetchAllHospitals() async{
    Position position;

    position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    String allHospitals = ApiUtil.ALL_HOSPITALS(position.latitude.toString(),position.longitude.toString());

    //print(allHospitals);
    var response = await http.get(allHospitals);

    List<Hospital> hospitals = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      //print(body['response']['venues']);
      for(var item in body['response']['venues']){
        Hospital hospital = Hospital.fromJson(item);
        hospitals.add(hospital);
      }
    }
    return hospitals;
  }
}