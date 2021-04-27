import 'package:graduation_project/models/general_location.dart';
class StoryImage{
  String id;
  DateTime time;
  String path;
  String caption;
  GeneralLocation location;
  String storyID;

  StoryImage(this.id,this.time,this.path, this.caption, this.location,this.storyID);

  StoryImage.fromJson(Map<String, dynamic> jsonObject)
  {
    this.id=jsonObject['id'].toString();
    this.time=DateTime.parse(jsonObject['time'].toString());
    this.path=jsonObject['path'].toString();
    if(  jsonObject['description']==null)
      this.caption="";

   else this.caption=jsonObject['description'].toString();
    this.location = GeneralLocation(jsonObject['lat'].toString(),jsonObject['lng'].toString());
    this.storyID=jsonObject['story_id'].toString();

  }
}