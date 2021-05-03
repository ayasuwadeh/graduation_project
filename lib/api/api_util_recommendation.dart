import 'package:url_launcher/url_launcher.dart';

class ApiUtilRecommendation{

  // FOR foursqaure requests
  static const String MAIN_FOURSQUARE_REQUEST = 'https://api.foursquare.com/v2/venues/search?';
  static const String MAIN_GOOGLE_REQUEST_RESTAURANT='https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=48.85470813453966, 2.347739392438203&radius=15000&type=restaurant&name=';
  static const String MAIN_DETAILS_REQUEST_GOOGLE='https://maps.googleapis.com/maps/api/place/details/json?place_id=';
  static const String FOURSQUARE_REQUEST = 'https://api.foursquare.com/v2/venues/';
  static const String FLASK_MAIN_REQUEST="http://10.0.2.2:5000/";
  static const String CLIENT_ID = 'client_id=2RPMC1UN4IL12SVLGQPDFUMYWJHBU10MCRR1BDBQPCIVK5MG';
  static const String CLIENT_SECRET = 'client_secret=YEOS2I23JAM05F420R0JHD1XUV5Z2JQXCO5LA1GTCKVNUS22';
  static const String GOOGLE_KEY="AIzaSyD0r9-PDf_iRZH1Kkf6LqyuSnUkw1bJBJ8";
  static const String V = 'v=20210316';


  static String GET_ALL_RESTAURANTS_RECOMMENDATION(String keywords){
    return FLASK_MAIN_REQUEST + 'restaurants?keywords='+ keywords ;
  }

  static String GET_ALL_PLACES_RECOMMENDATION(String keywords){
    return FLASK_MAIN_REQUEST + 'places?keywords='+ keywords ;
  }

  static String GET_ALL_CITIES_RECOMMENDATION(String keywords){
    return FLASK_MAIN_REQUEST + 'cities?plan='+ keywords ;
  }

  static String GET_ALL_SIMILAR_PLACES(String id){
    return FLASK_MAIN_REQUEST + 'similarPlaces?ID='+ id ;
  }

  static String GET_GOOGLE_DETAILS(String name){

    return MAIN_GOOGLE_REQUEST_RESTAURANT + name + '&key=' + GOOGLE_KEY ;
  }

  static String GET_GOOGLE_DETAILS_PLACES(String name){

    return MAIN_GOOGLE_REQUEST_RESTAURANT + name + '&key=' + GOOGLE_KEY ;
  }

  static String PLACE_DETAILS_GOOGLE(String id){
    return MAIN_DETAILS_REQUEST_GOOGLE + id + '&' + '&fields=name,opening_hours,photos,price_level,formatted_phone_number&key=' +GOOGLE_KEY ;
  }




}