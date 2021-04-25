import 'package:url_launcher/url_launcher.dart';

class ApiUtilOCR {

  // FOR foursqaure requests
  static const String FLASK_MAIN_REQUEST="http://10.0.2.2:5000/";


  static String GET_ALL_RESTAURANTS_RECOMMENDATION(String path) {
    return FLASK_MAIN_REQUEST + 'OCR?path='+ path ;

  }
}
