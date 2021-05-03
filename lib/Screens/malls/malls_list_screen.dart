import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/api/hospitals_api.dart';
import 'package:graduation_project/api/malls_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/models/shopping_mall.dart';
import 'package:graduation_project/constants.dart';
import 'mall_card.dart';
import 'package:graduation_project/constants.dart';
class MallsListScreen extends StatelessWidget {
  List <ShoppingMall> malls;

  MallsListScreen( this.malls);

  @override
  Widget build(BuildContext context) {
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
          Text("Shopping Malls", style: TextStyle(color: Colors.black87,fontSize: 22),)
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MallsListWidget(malls),
          ],
        ),
      ),
    );
  }
}

class MallsListWidget extends StatefulWidget {
  List <ShoppingMall> malls;
MallsListWidget(this.malls);
  @override
  _MallsListWidgetState createState() => _MallsListWidgetState();
}

class _MallsListWidgetState extends State<MallsListWidget> {
  List <ShoppingMall> _searchedMalls=new List <ShoppingMall>();
  bool searchTapped=false;
  @override
  void initState() {
    _searchedMalls=widget.malls;
    _searchedMalls.sort((a, b) => a.location.distance.compareTo(b.location.distance));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Expanded(

        child:
            _buildMallList(_searchedMalls),

    );

  }


  Widget _buildMallList(List<ShoppingMall> malls){
    print(malls.length.toString());
    Size size = MediaQuery.of(context).size;

    return  SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: malls.length+1,
        itemBuilder: (BuildContext context, int index){
          if(index==0)
            return searchBar();
          else
            return MallCard(mall: malls[index-1],);
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
                      _searchedMalls=widget.malls.where((hotel) {
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



