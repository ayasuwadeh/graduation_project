import 'package:graduation_project/models/general_location.dart';
class StoryImage{
  String id;
  String path;
  String caption;
  GeneralLocation location;

  StoryImage(this.id,this.path, this.caption, this.location);

  StoryImage.fromJson(Map<String, dynamic> jsonObject)
  {
    this.id=jsonObject['id'].toString();
    this.path=jsonObject['path'].toString();
    this.caption = jsonObject['caption'].toString();
    this.location = GeneralLocation(jsonObject['lat'].toString(),jsonObject['lng'].toString());

  }
}