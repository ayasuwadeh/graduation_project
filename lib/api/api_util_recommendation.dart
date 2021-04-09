import 'package:url_launcher/url_launcher.dart';

class ApiUtilRecommendation{

  // FOR foursqaure requests
  static const String MAIN_FOURSQUARE_REQUEST = 'https://api.foursquare.com/v2/venues/search?';
  static const String MAIN_GOOGLE_REQUEST_RESTAURANT='https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=48.85470813453966, 2.347739392438203&radius=15000&type=restaurant&name=';
  static const String MAIN_DETAILS_REQUEST_GOOGLE='https://maps.googleapis.com/maps/api/place/details/json?place_id=';
  static const String FOURSQUARE_REQUEST = 'https://api.foursquare.com/v2/venues/';
  static const String FLASK_MAIN_REQUEST="http://10.0.2.2:5000/restaurants?keywords=";
  static const String CLIENT_ID = 'client_id=2RPMC1UN4IL12SVLGQPDFUMYWJHBU10MCRR1BDBQPCIVK5MG';
  static const String CLIENT_SECRET = 'client_secret=YEOS2I23JAM05F420R0JHD1XUV5Z2JQXCO5LA1GTCKVNUS22';
  static const String GOOGLE_KEY="AIzaSyD0r9-PDf_iRZH1Kkf6LqyuSnUkw1bJBJ8";
  static const String V = 'v=20210316';


  static String GET_ALL_RESTAURANTS_RECOMMENDATION(String keywords){
    return FLASK_MAIN_REQUEST +keywords ;
  }

  static String GET_GOOGLE_DETAILS(String name){

    return MAIN_GOOGLE_REQUEST_RESTAURANT + name + '&key=' + GOOGLE_KEY ;
  }


  static String PLACE_DETAILS_GOOGLE(String id){
    return MAIN_DETAILS_REQUEST_GOOGLE + id + '&' + '&fields=name,opening_hours,photos,price_level,formatted_phone_number&key=' +GOOGLE_KEY ;
  }

  static String ALL_MARKETS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' ;
  }

  static String ALL_HOTELS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' ;
  }

  static String HOTEL_RATE(String id){
    return FOURSQUARE_REQUEST +id+'?'+ CLIENT_ID + '&' + CLIENT_SECRET + '&' + V ;
  }
  static String HOTEL_IMAGE(String id){
    return FOURSQUARE_REQUEST +id+'/photos'+'?'+ CLIENT_ID + '&' + CLIENT_SECRET + '&' + V+'&group=venue&limit=1' ;
  }

  static String GALLARIES(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' ;
  }

  static String ZOOS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' ;
  }

  static String PARKS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' ;
  }
  static String BEACH(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' ;
  }

  static String MUSEUM(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' ;
  }
  static String DIRECTION(String latitudeSrc, String longitudeSrc,
      String latitudeDest,String longitudeDest)
  {
    _launchURL('https://www.google.com/maps/dir/'+latitudeSrc+','
        +longitudeSrc+'/'+latitudeDest+','+longitudeDest);
  }
  static _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';






}