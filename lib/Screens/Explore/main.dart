import 'package:flutter/material.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'page_view_widget.dart';
// import 'package:graduation_project/components/autocomplete_search_bar.dart';
import 'multi_selection_chip.dart';
import 'package:graduation_project/api/city_recommendation_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/models/recommendation_city.dart';
import 'package:graduation_project/constants.dart';
class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> selectedReportList = List();
  List<RecommendationCity> recommendationCities=[];
  CityRecommendationApi cityRecommendationApi=new CityRecommendationApi();
  bool firstTime=true;
  bool searchBased=false;
  List <RecommendationCity> _searchedCities=new List <RecommendationCity>();
  int counter=0;
  bool searchTapped=false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(activePage: 'Explore',),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(
              top: height * 0.085,
            ),
            child: Row(
              children: [
                searchBar(),
                SizedBox(width: width * 0.08,),
                IconButton(
                  icon: Icon(Icons.filter_list, size: 27,),
                  onPressed: () {
                    setState(() {
                      searchBased=false;
                    });
                    _showReportDialog();
                    print(selectedReportList);
                  },

                )
              ],
            ),
          ),
        !searchBased?Expanded(
            child: FutureBuilder(
                key: ValueKey(searchTapped),
                future: cityRecommendationApi.fetchCities(selectedReportList.join(',')),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                         print(snapshot.data);
                        firstTime=false;
                        if(counter==0)
                          {
                            recommendationCities=snapshot.data;
                            counter=1;
                          }
                        return PageViewWidget(recommendationCities: snapshot.data,);
                      }
                  }
                  return Container(
                    color: Colors.white,
                  );
                }),


          ):
            Expanded(
              child: PageViewWidget(recommendationCities: _searchedCities,),
            )

        ],
      ),
    );
  }

  List<String> reportList = [
    "history",
    "art",
    "architecture",
    "city",
    "culture",
    "beach",
    "parks",
    "nature",
    "sun",
    "sea",
    "sand",
    "seaside",
    "wildlife",
    "valley",


  ];


  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),

            title: Text("what do you need in your next vacation?"),
            content: MultiSelectChip(
              reportList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Done"),
                onPressed: () {
          Navigator.of(context).pop();

          }
              )
            ],
          );
        });
  }
  Widget searchBar()
  {    Size size = MediaQuery.of(context).size;

  return  Padding(
    padding: EdgeInsets.only(left:size.width*0.1),
    child: Column(
      children: [
        Container(
          height: size.height*0.08,
          width: size.width*0.64,
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
                      hintText: 'find your next adventure...',
                      hintStyle: TextStyle(color: Colors.grey.shade700,fontSize:15,)
                  ),
                  onTap: ()
                  {
                    setState(() {
                      searchBased=true;
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
                      _searchedCities=recommendationCities.where((hotel) {
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




