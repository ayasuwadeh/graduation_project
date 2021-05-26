import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/models/path-point.dart';
import 'package:graduation_project/services/sql_lite/image_functions.dart';
import 'package:graduation_project/services/sql_lite/point_functions.dart';
import 'general_location.dart';


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

   UserStory.fromJson(Map<String, dynamic> jsonObject){
    int index = 0;

    this.storyImages = List<StoryImage>();
    this.userPath = List<PathPoint>();
    this.name = jsonObject['name'].toString();
    this.city = jsonObject['city'].toString();
    this.country = jsonObject['country'].toString();
    this.time = DateTime.parse(jsonObject['dateCreated'].toString());

    for(var img in jsonObject['images'] ){
      this.storyImages.add(StoryImage.fromJsonDatabase(img));
    }

    for(var pointJson in jsonObject['points'] ){
      List<String> pointString = pointJson.toString().split(', ');
      GeneralLocation location = new GeneralLocation(pointString[0] , pointString[1]);
      PathPoint point = new PathPoint('', location ,index.toString() , '');
      index++;
      this.userPath.add(point);
    }

  }

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