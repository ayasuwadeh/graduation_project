import 'package:flutter/cupertino.dart';

class Place {
  final String name;
  final double rating;
  final int phoneNumber;
  //final int countPosts;
  //final String urlImage;
  final String location;
  final String bio;
  //final List<String> urlPhotos;
  //bool isFollowing;

  Place({
    @required this.name,
    @required this.rating,
    @required this.phoneNumber,
   // @required this.countPosts,
    //@required this.urlImage,
    @required this.location,
    @required this.bio,
   // @required this.urlPhotos,
   // this.isFollowing,
  });
}
