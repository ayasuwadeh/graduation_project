import 'package:flutter/material.dart';
import 'package:graduation_project/models/gallary.dart';
import 'package:graduation_project/api/gallaries_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'gallery_card.dart';
import 'package:graduation_project/constants.dart';
class Galleries extends StatelessWidget {
  int index;
  String categoryName;
  Galleries(this.index,this.categoryName);
  List<Gallery> galleries= new List<Gallery>();
  GalleryApi galleryApi = GalleryApi();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.deepOrange,),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },),
          backgroundColor: Colors.white,
          title:
          Text(this.categoryName, style: TextStyle(color: Colors.black87,fontSize: 22),)
      ),
      body:FutureBuilder(
          future: galleryApi.fetchAllGalleries(index),
          builder: (BuildContext context,
              AsyncSnapshot snapshot) {
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
                  return Error(errorText: snapshot.error
                      .toString());
                  break;
                }
                else if (snapshot.hasData) {
                  {print(snapshot.data);
                  galleries=snapshot.data;
                  galleries.sort((a, b) => a.location.distance.compareTo(b.location.distance));
                  return GalleriesListScreen(galleries);
                  }
                }
            }
            return Container(color: Colors.white,);
          }
      )
    );
  }
}

class GalleriesListScreen extends StatefulWidget {
  List<Gallery> galleries= new List<Gallery>();
  GalleriesListScreen(this.galleries);
  @override
  _GalleriesListScreenState createState() => _GalleriesListScreenState();
}

class _GalleriesListScreenState extends State<GalleriesListScreen> {
  List<Gallery> searchedGalleries= new List<Gallery>();
  bool searchTapped=false;

  final TextEditingController controller = new TextEditingController();

  @override
  void initState() {
       searchedGalleries=widget.galleries;
       print("hhhh");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return widget.galleries.length>0?SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            itemList(searchedGalleries),
          ],
        ),

    ):Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "no places around",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 22,
              //fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );


  }
  Widget itemList(List<Gallery> galleries)
  { //print('jjjjjj'+galleries[0].name);
   return
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: galleries.length+1,
          itemBuilder: (BuildContext context, int index){
            if(index==0)
              return searchBar();
            else
            return GalleryCard(
              gallery: galleries[index-1],
            );
          },
          //children: List.from(hotelCards)
        ),
    );
  }
  Widget searchBar() {
    Size size = MediaQuery
        .of(context)
        .size;

    return Padding(
      padding: EdgeInsets.only(left: size.width * 0),
      child: Column(
        children: [
          Container(
            width: size.width * 0.84,
            // margin: EdgeInsets.only(bottom: size.width * 0.02),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 22),
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    // key:_formKey,
                    style: TextStyle(color: Colors.black, fontSize: 20,
                    ),
                    decoration: new InputDecoration(
                        hintText: 'search...',
                        hintStyle: TextStyle(color: Colors.grey.shade700,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)
                    ),
                    onTap: ()
                    {
                      setState(() {
                        searchTapped=true;
                      });
                    },
                    onSubmitted:(string)
                    {
                      setState(() {
                        searchTapped=false;
                      });
                    },

                    onChanged: (text) {
                      text = text.toLowerCase();
                      setState(() {
                        searchedGalleries = widget.galleries.where((hotel) {
                          var hotelName = hotel.name.toLowerCase();
                          return hotelName.contains(text);
                        }).toList();
                      });
                    },
                  ),
                ),
                Icon(
                  Icons.search,
                  color: searchTapped?kPrimaryColor:Colors.black.withAlpha(120),
                ),

              ],
            ),
          )
        ],
      ),


    );
  }
}
