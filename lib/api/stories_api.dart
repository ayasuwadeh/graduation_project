import 'package:graduation_project/models/user-story.dart';
import 'package:graduation_project/services/user_preferences.dart';

import 'api_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoriesAPI {
  Future<List<UserStory>> fetchAllStories() async {
    Future<Map<String, String>> headers = UserPreferences()
        .getToken()
        .then((token) => getHeaders(token));

    var response = await headers.then((header) => http.get(ApiUtil.allStories, headers: header));
    List<UserStory> stories = List<UserStory>();

    if(response.statusCode == 200){
      final Map<String, dynamic> data = json.decode(response.body);
      for(var story in data['data']){
        print(story['dateCreated']);
        UserStory userStory = UserStory.fromJson(story);
        stories.add(userStory);
      }
    }
    return stories;
  }

  getHeaders(String token) {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
      'content-type': 'application/json'
    };
    return headers;
  }
}
