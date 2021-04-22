import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/api/hotels_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/models/hotel.dart';
import 'package:graduation_project/constants.dart';
import 'hotel_card.dart';
import 'search_bar.dart';
import 'package:graduation_project/constants.dart';
class HotelsListScreen extends StatelessWidget {
   List <Hotel> hotels;

   HotelsListScreen( this.hotels);
  @override
  Widget build(BuildContext context) {
    HotelApi hotelApi = HotelApi();
   // print(hotels[0].name);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

          leading: IconButton(icon:Icon(Icons.arrow_back,color: kPrimaryColor,),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },),
          backgroundColor: Colors.white,
          title:
          Text("Hotels", style: TextStyle(color: Colors.black87,fontSize: 22),)
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height*0.034,),

            MallsListWidget(hotels:hotels),

        ],
        ),
      ),
    );
  }

}

class MallsListWidget extends StatefulWidget {
  List <Hotel> hotels;

   MallsListWidget({Key key, this.hotels}) : super(key: key);
  @override
  _MallsListWidgetState createState() => _MallsListWidgetState();
}

class _MallsListWidgetState extends State<MallsListWidget> {
  List <Hotel> _searchedHotels=new List <Hotel>();

  bool searchTapped=false;

  @override
  void initState() {
    _searchedHotels=widget.hotels;
    _searchedHotels.sort((a, b) => a.location.distance.compareTo(b.location.distance));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            searchBar(),
            _buildMallList(_searchedHotels),
          ],
        ),
      ),
    );

  }


  Widget _buildMallList(List<Hotel> malls){
   print(malls.length.toString());
   Size size = MediaQuery.of(context).size;

   return  SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: malls.length,
            itemBuilder: (BuildContext context, int index){
              if (malls.length>0)
                return HotelCard(hotel: malls[index],);
              else return searchBar();
            },
          ),
       );
  }

  Widget searchBar()
  {    Size size = MediaQuery.of(context).size;

  return  Padding(
      padding: EdgeInsets.only(left:size.width*0),
      child: Column(
        children: [
          Container(
            width: size.width*0.84,
           // margin: EdgeInsets.only(bottom: size.width*0.02),
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
                   // key:_formKey,
                    style: TextStyle(color: Colors.black,fontSize: 20,
                    ),
                    decoration: new InputDecoration(
                        hintText: 'search...',
                        hintStyle: TextStyle(color: Colors.grey.shade700,fontSize:17,fontWeight: FontWeight.bold)
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

                    onChanged: (text){
                      text=text.toLowerCase();
                      setState(() {
                        _searchedHotels=widget.hotels.where((hotel) {
                            var hotelName=hotel.name.toLowerCase();
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
  change() {
    setState(() {
      print("hiiii");
    });
  }
}



