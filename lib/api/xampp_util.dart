import 'package:http/http.dart' as http;
class XamppUtilAPI {

  static const String XAMPP_MAIN_REQUEST="http://10.0.2.2:80/";
  static final String UPLOAD_FILE_FUNCTION ='story_images/upload_image.php';



  static Future<String> UPLOAD_IMAGE(String fileName,String base64Image) {
    http.post(XAMPP_MAIN_REQUEST+UPLOAD_FILE_FUNCTION, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      return(result.statusCode == 200 ? result.body : "error uploading image");
    }).catchError((error) {
      return("error uploading image");
    });
  }

  }

