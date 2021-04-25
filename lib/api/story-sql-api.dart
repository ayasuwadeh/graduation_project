import 'package:http/http.dart' as http;
import 'package:graduation_project/services/sql_lite/story_functions.dart';
import 'package:graduation_project/models/user-story.dart';
import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/models/path-point.dart';
import 'package:graduation_project/services/sql_lite/image_functions.dart';
import 'package:graduation_project/models/general_location.dart';
import 'package:graduation_project/models/path-point.dart';
import 'dart:convert';
class StorySQLApi {

  List<UserStory> userStories=[];

  Future <List<UserStory>> fetchAllStories( ) async {
    List<UserStory> userStories=[];
    final allRows = await StoryFunctions.queryAllRows();
    for(var item in allRows)
      {
        print(item);
       userStories.add(await UserStory.createStory(item));
      }
      return userStories;
  }

}

