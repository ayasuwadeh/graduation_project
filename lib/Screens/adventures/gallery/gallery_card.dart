import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/hospital.dart';
import 'package:graduation_project/Screens/Hotels/map_card.dart';
import 'package:graduation_project/Screens/Details/page/main_page.dart';
import 'package:graduation_project/api/item_details_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/models/gallary.dart';
class GalleryCard extends StatelessWidget {
  Gallery gallery;
  ItemDetailsApi itemDetailsApi = ItemDetailsApi();

  GalleryCard({Key key, this.gallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
       onTap: ()
       {
         Navigator.push(context,
             MaterialPageRoute(builder: (context) {
                  return PlaceWidget(gallery);
                           }));

       },
      child: Container(
        //height: size.height * 0.25,
        margin: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryLightColor, borderRadius: BorderRadius.circular(29)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        gallery.category.name,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      //SizedBox(height: 8,),
                      Text(
                        gallery.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        //TODO : put small location icon in grey
                        gallery.location.address,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Distance: ' + gallery.location.distance.toString(),
                        style: TextStyle(
                          fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  //TODO : open map with location of the place
                  Icons.location_on,
                  color: kPrimaryColor,
                  size: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
