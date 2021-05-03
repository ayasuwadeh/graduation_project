import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/api/markets_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/models/market.dart';
import 'package:graduation_project/constants.dart';
import 'market_card.dart';
import 'package:graduation_project/components/autocomplete_search_bar.dart';

class MarketsListScreen extends StatelessWidget {
 List <Market> markets;
 MarketsListScreen(this.markets);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.deepOrange,),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },),
          backgroundColor: Colors.white,
          title:
          Text("Markets", style: TextStyle(color: Colors.black87,fontSize: 22),)
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MallsListWidget(hotels: this.markets,),
          ],
        ),
      ),
    );
  }
}

class MallsListWidget extends StatefulWidget {
  List <Market> hotels;

  MallsListWidget({Key key, this.hotels}) : super(key: key);
  @override
  _MallsListWidgetState createState() => _MallsListWidgetState();
}

class _MallsListWidgetState extends State<MallsListWidget> {
  List <Market> _searchedMarkets=new List <Market>();

  bool searchTapped=false;

  @override
  void initState() {
    _searchedMarkets=widget.hotels;
    _searchedMarkets.sort((a, b) => a.location.distance.compareTo(b.location.distance));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child:
            _buildMallList(_searchedMarkets),

    );

  }


  Widget _buildMallList(List<Market> malls){
    print(malls.length.toString());
    Size size = MediaQuery.of(context).size;

    return   ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: malls.length+1,
        itemBuilder: (BuildContext context, int index){
          if (index==0)
            return searchBar();
          else
            return MarketCard(market: malls[index-1],);
        },

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
          //margin: EdgeInsets.only(bottom: size.width*0.02),
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
                      _searchedMarkets=widget.hotels.where((hotel) {
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
}

