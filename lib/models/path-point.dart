import 'package:graduation_project/models/general_location.dart';
class PathPoint{
  String id;
  GeneralLocation location;
  String sequence;
  String storyID;

  PathPoint(this.id,this.location,this.sequence,this.storyID);


  PathPoint.fromJson(Map<String, dynamic> jsonObject)
  {
    this.id=jsonObject['id'].toString();
    this.location = GeneralLocation(jsonObject['lat'].toString(),jsonObject['lng'].toString());
    this.sequence=jsonObject['seq'].toString();
    this.storyID=jsonObject['story_id'].toString();
  }

  void setLocation({String lat, String lan}){
    this.location.lat = lat;
    this.location.lan = lan;
  }

  @override
  String toString() {
    return this.location.lat + ", " + this.location.lan;
  }

}