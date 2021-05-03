import 'package:flutter/material.dart';
import 'package:graduation_project/components/bottom_navigation_bar.dart';
import 'page_view_widget.dart';
import 'package:graduation_project/components/autocomplete_search_bar.dart';
import 'multi_selection_chip.dart';
import 'package:graduation_project/api/city_recommendation_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/models/recommendation_city.dart';
class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> selectedReportList = List();
  List<RecommendationCity> recommendationCities=[];
  CityRecommendationApi cityRecommendationApi=new CityRecommendationApi();
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

    return Scaffold(
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
                SearchBar(hint: "Find Your Next Adventure"),
                SizedBox(width: width * 0.08,),
                IconButton(
                  icon: Icon(Icons.filter_list, size: 27,),
                  onPressed: () {
                    _showReportDialog();
                    print(selectedReportList);
                  },

                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
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
                        // print(snapshot.data);
                        List<RecommendationCity> cities = snapshot.data;

                        return PageViewWidget(recommendationCities: snapshot.data,);
                      }
                  }
                  return Container(
                    color: Colors.white,
                  );
                }),


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
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }


  }




