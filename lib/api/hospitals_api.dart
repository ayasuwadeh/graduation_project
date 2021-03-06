import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/hospital.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HospitalApi{

  Future<List<Hospital>> fetchAllHospitals() async{
    //TODO : make location dynamic
    String allHospitals = ApiUtil.ALL_HOSPITALS('40.7099', '-73.9622');

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