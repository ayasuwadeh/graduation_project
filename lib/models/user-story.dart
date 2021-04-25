import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/models/path-point.dart';
import 'package:graduation_project/models/path-point.dart';
import 'package:graduation_project/services/sql_lite/image_functions.dart';
import 'package:graduation_project/services/sql_lite/point_functions.dart';
class UserStory {
  String id;
  String name;
  String city;
  String country;

  List<StoryImage> storyImages;
  List<PathPoint> userPath;

  UserStory(this.id,this.name,this.city,this.country,this.storyImages,this.userPath);

  static Future<UserStory>createStory(Map<String, dynamic> jsonObject) async {
    String id=jsonObject['id'].toString();
    String name = jsonObject['name'].toString();
    String city = jsonObject['city'].toString();
    String country=jsonObject['country'].toString();
    List<StoryImage> images= await fetchImagesOfStory(id);
    List <PathPoint> points=await fetchPointsOfStory(id);
    UserStory temp=new UserStory(id, name, city, country, images, points);
     return temp;


  }

 static Future<List<StoryImage>> fetchImagesOfStory(String id) async {
    final allRows = await ImageFunctions.queryRow(id);
    List <StoryImage> images=[];
    allRows.forEach((row)
    {      print(row);

    StoryImage storyImage=StoryImage.fromJson(row);
      images.add(storyImage);
    });

    return images;
  }

  static Future <List<PathPoint>> fetchPointsOfStory(String id) async{
    final allRows = await PointFunctions.queryRow(id);
    List <PathPoint> points=[];
    allRows.forEach((row)
    {
      print(row);

      PathPoint pathPoint=PathPoint.fromJson(row);
      points.add(pathPoint);
    });
return points;

  }

}