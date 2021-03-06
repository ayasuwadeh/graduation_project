class ApiUtil{

  static const String MAIN_API_UTIL = 'http://10.0.2.2:8000/api';

  static const String ALL_NATURES = '/natures';

  static const String ALL_CUISINES = '/cuisines';

  static const String ALL_CULTURES = '/cultures';


  // FOR foursqaure requests
  static const String MAIN_FOURSQUARE_REQUEST = 'https://api.foursquare.com/v2/venues/search?';
  static const String CLIENT_ID = 'client_id=2RPMC1UN4IL12SVLGQPDFUMYWJHBU10MCRR1BDBQPCIVK5MG';
  static const String CLIENT_SECRET = 'client_secret=YEOS2I23JAM05F420R0JHD1XUV5Z2JQXCO5LA1GTCKVNUS22';
  static const String V = 'v=20210219';

  static const String HOSPITAL_CATEGORY_ID = 'categoryId=4bf58dd8d48988d104941735';
  static const String SHOPPING_MALL_CATEGORY_ID = 'categoryId=4bf58dd8d48988d1fd941735';
  static const String CURRENCY_EXCHANGE_CATEGORY_ID = 'categoryId=5744ccdfe4b0c0459246b4be';
  static const String MARKET_CATEGORY_ID = 'categoryId=50be8ee891d4fa8dcc7199a7';
  static const String HOTEL_CATEGORY_ID = 'categoryId=4bf58dd8d48988d1fa931735';

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


}