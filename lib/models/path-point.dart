import 'package:graduation_project/models/general_location.dart';
class PathPoint{
  String id;
  GeneralLocation location;
  String sequence;

  PathPoint(this.id,this.location,this.sequence);
  PathPoint.fromJson(Map<String, dynamic> jsonObject)
  {
    this.id=jsonObject['id'].toString();
    this.location = GeneralLocation(jsonObject['lat'].toString(),jsonObject['lng'].toString());
    this.sequence=jsonObject['seq'].toString();

  }

}