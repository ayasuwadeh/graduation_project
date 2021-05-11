import 'package:graduation_project/models/category.dart';
import 'package:graduation_project/models/general_location.dart';

class FoursquareDetails{
  GeneralLocation location=new GeneralLocation((-200).toString(),(-200).toString());
  String description;
  String phoneNumber;
  String url;
  bool isOpen;

  FoursquareDetails( );

  FoursquareDetails.fromJson(Map<String, dynamic> jsonObject) {
    this.location.lat = jsonObject['location']['lat'].toString();
    this.location.lan = jsonObject['location']['lng'].toString();

print(this.location.lat);

    if(jsonObject['url']!=null)
      this.url=jsonObject['url'];
    else this.url='not found';


    if(jsonObject['contact']['phone']!=null)
      this.phoneNumber='tel:'+jsonObject['contact']['phone'];
    else this.phoneNumber='tel:0';


    if(jsonObject['description']!=null)
      this.description=jsonObject['description'];
    else this.description='a gallery';


    if(jsonObject['popular']!=null)
      if(jsonObject['popular']['isOpen']!=null)
        this.isOpen=jsonObject['popular']['isOpen'];
      else this.isOpen=false;
    else this.isOpen=false;



  }


}