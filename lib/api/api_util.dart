import 'package:url_launcher/url_launcher.dart';
class ApiUtil{

  static const String MAIN_API_UTIL = 'http://10.0.2.2:8000/api';

  static const String ALL_NATURES = '/natures';
  static const String ALL_CUISINES = '/cuisines';
  static const String ALL_CULTURES = '/cultures';

  static const String login = MAIN_API_UTIL + '/auth/login';
  static const String signUp = MAIN_API_UTIL + '/auth/register';
  static const String logout = MAIN_API_UTIL + '/auth/logout';
  static const String countryAndBirthday = MAIN_API_UTIL + '/user/data';
  static const String editInfo = MAIN_API_UTIL + '/user/edit';
  static const String changeEmail = MAIN_API_UTIL + '/user/editEmail';
  static const String changePassword = MAIN_API_UTIL + '/user/change-password';
  static const String storeCuisines = MAIN_API_UTIL + '/user/cuisines';
  static const String storeCultures = MAIN_API_UTIL + '/user/cultures';
  static const String storeNatures = MAIN_API_UTIL + '/user/natures';
  static const String sendResetPasswordCode = MAIN_API_UTIL + '/forgot-password';
  static const String validatePasswordResetToken = MAIN_API_UTIL + '/forgot-password/code';
  static const String resetPassword = MAIN_API_UTIL + '/reset-password';
  static const String saveStory = MAIN_API_UTIL + '/user/save-story';
  static const String allStories = MAIN_API_UTIL + '/user/stories';
  static const String userEntertainmentsBookmarks = MAIN_API_UTIL + '/user/entertainments/';
  static const String userRestaurantsBookmarks = MAIN_API_UTIL + '/user/restaurants/';





  // FOR foursqaure requests
  static const String MAIN_FOURSQUARE_REQUEST = 'https://api.foursquare.com/v2/venues/search?';
  static const String FOURSQUARE_REQUEST = 'https://api.foursquare.com/v2/venues/';

  static const String CLIENT_ID = 'client_id=WGDK1ZR0RRJZMOCQQFYEPRJHKOAJ2RQMUNITX3CIJI5M0UVU';
  static const String CLIENT_SECRET = 'client_secret=ZLC0CNJJ0TM1RI424WNR2ASI5533QTHJHLDCM4IMEVPO3C4H';
  static const String V = 'v=20210316';

  static const String HOSPITAL_CATEGORY_ID = 'categoryId=4bf58dd8d48988d104941735';
  static const String SHOPPING_MALL_CATEGORY_ID = 'categoryId=4bf58dd8d48988d1fd941735';
  static const String CURRENCY_EXCHANGE_CATEGORY_ID = 'categoryId=5744ccdfe4b0c0459246b4be';
  static const String MARKET_CATEGORY_ID = 'categoryId=50be8ee891d4fa8dcc7199a7';
  static const String HOTEL_CATEGORY_ID = 'categoryId=4bf58dd8d48988d1fa931735';
  static const String ART_GALLERY_CATEGORY_ID = 'categoryId=4bf58dd8d48988d1e2931735';
  static const String ZOO_CATEGORY_ID = 'categoryId=4bf58dd8d48988d17b941735';
  static const String PARK_CATEGORY_ID = 'categoryId=4bf58dd8d48988d163941735';
  static const String BEACH_CATEGORY_ID = 'categoryId=4bf58dd8d48988d1e2941735';
  static const String MUSEUMS_CATEGORY_ID = 'categoryId=4bf58dd8d48988d181941735';


  static String ALL_HOSPITALS(String latitude, String longitude){
  return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + HOSPITAL_CATEGORY_ID;
  }

  static String ALL_MALLS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + SHOPPING_MALL_CATEGORY_ID;
  }

  static String ALL_CURRENCY_EXCHANGE(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + CURRENCY_EXCHANGE_CATEGORY_ID;
  }

  static String ALL_MARKETS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + MARKET_CATEGORY_ID;
  }

  static String ALL_HOTELS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + HOTEL_CATEGORY_ID;
  }

  static String HOTEL_RATE(String id){
    return FOURSQUARE_REQUEST +id+'?'+ CLIENT_ID + '&' + CLIENT_SECRET + '&' + V ;
  }
  static String HOTEL_IMAGE(String id){
    return FOURSQUARE_REQUEST +id+'/photos'+'?'+ CLIENT_ID + '&' + CLIENT_SECRET + '&' + V+'&group=venue&limit=1' ;
  }

  static String GALLARIES(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + ART_GALLERY_CATEGORY_ID;
  }

  static String ZOOS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + ZOO_CATEGORY_ID;
  }

  static String PARKS(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + PARK_CATEGORY_ID;
  }
  static String BEACH(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + BEACH_CATEGORY_ID;
  }

  static String MUSEUM(String latitude, String longitude){
    return MAIN_FOURSQUARE_REQUEST + CLIENT_ID + '&' + CLIENT_SECRET + '&' + V + '&' + 'll=' + latitude + ',' + longitude + '&' + 'intent=checkin&radius=5000&limit=50' + '&' + MUSEUMS_CATEGORY_ID;
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