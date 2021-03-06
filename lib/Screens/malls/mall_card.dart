import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/shopping_mall.dart';
import 'package:graduation_project/models/item_details.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/api/item_details_api.dart';
import 'package:graduation_project/Screens/Hotels/map_screen.dart';

class MallCard extends StatelessWidget {
  ShoppingMall mall;
  Future <ItemDetails> details;
  ItemDetailsApi itemDetailsApi = ItemDetailsApi();

  MallCard({Key key, this.mall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
       onTap: ()
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                print("hereeeeeeeeeeeee");
                return
                  FutureBuilder(
                      future: itemDetailsApi.fetchDetails(mall.id),
                      builder: (BuildContext context,
                          AsyncSnapshot snapshot){

                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                            return Loading();
                            break;
                          case ConnectionState.waiting:
                            return Loading();
                            break;
                          case ConnectionState.none:
                            return Error(errorText: 'No Internet Connection');
                            break;
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Error(errorText: snapshot.error.toString());
                              break;
                            } else if (snapshot.hasData) {
                              return MapScreen(details: snapshot.data,
                                item: mall,);
                              break;
                            }
                        }
                        return Container();
                      }
                  );            }));
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
                        mall.category.name,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      //SizedBox(height: 8,),
                      Text(
                        mall.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        //TODO : put small location icon in grey
                        mall.location.formattedAddress,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Distance: ' + mall.location.distance.toString(),
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
