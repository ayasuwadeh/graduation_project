import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/models/path-point.dart';
import 'package:graduation_project/models/path-point.dart';
import 'package:graduation_project/services/sql_lite/image_functions.dart';
import 'package:graduation_project/services/sql_lite/point_functions.dart';
class UserStory {
  String id;
  String synced;
  DateTime time;
  String name;
  String city;
  String country;

  List<StoryImage> storyImages;
  List<PathPoint> userPath;

  UserStory(this.id,this.time,this.name,this.city,this.country,this.storyImages,this.userPath,this.synced);

  static Future<UserStory>fetchAllStories(Map<String, dynamic> jsonObject) async {
    String id=jsonObject['id'].toString();
    String synced=jsonObject['synced'].toString();
    String name = jsonObject['name'].toString();
    DateTime time =DateTime.parse( jsonObject['time']);
    String city = jsonObject['city'].toString();
    String country=jsonObject['country'].toString();
    List<StoryImage> images= await fetchImagesOfStory(id);
    List <PathPoint> points=await fetchPointsOfStory(id);
    UserStory temp=new UserStory(id,time,name, city, country, images, points,synced );
     return temp;


  }

  static Future<UserStory>fetchStory(Map<String, dynamic> jsonObject) async {
    String id=jsonObject['id'].toString();
    String name = jsonObject['name'].toString();
    String synced=jsonObject['synced'].toString();
    DateTime time =DateTime.parse( jsonObject['time']);
    String city = jsonObject['city'].toString();
    String country=jsonObject['country'].toString();
    List<StoryImage> images= await fetchImagesOfStory(id);
    List <PathPoint> points=await fetchPointsOfStory(id);
    UserStory temp=new UserStory(id, time,name, city, country, images, points,synced);
    return temp;


  }

  static Future<List<StoryImage>> fetchImagesOfStory(String id) async {
    final allRows = await ImageFunctions.queryRow(id);
    List <StoryImage> images=[];
    allRows.forEach((row)
    {      //print(row.toString()+"nice one");

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
      //print(row);

      PathPoint pathPoint=PathPoint.fromJson(row);
      points.add(pathPoint);
    });
return points;

  }


}