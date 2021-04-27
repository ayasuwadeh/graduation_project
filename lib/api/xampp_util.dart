import 'package:http/http.dart' as http;
class XamppUtilAPI {

  static const String XAMPP_MAIN_REQUEST="http://10.0.2.2:80/";
  static final String UPLOAD_FILE_FUNCTION ='story_images/upload_image.php';



  // ignore: non_constant_identifier_names
  static Future<int> UPLOAD_IMAGE(String fileName,String base64Image) async {
    bool done=false;
    var response= await http.post(XAMPP_MAIN_REQUEST+UPLOAD_FILE_FUNCTION, body: {
      "image": base64Image,
      "name": fileName,
    });
    if(response.statusCode==200)
      done=true;
    else done=false;

    return done?1:0;
  }

  }

