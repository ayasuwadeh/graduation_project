import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/api/hospitals_api.dart';
import 'package:graduation_project/api/malls_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/models/shopping_mall.dart';
import 'package:graduation_project/constants.dart';
import 'mall_card.dart';
import 'package:graduation_project/components/autocomplete_search_bar.dart';
class MallsListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 29, top: 20, bottom: 20),
              child: Row(
                children: [
                  InkWell(
                    //TODO make it go back
                      child: Icon(
                        Icons.arrow_back,
                        color: kPrimaryColor,
                        size: 30,
                      )
                  ),
                  Text(
                    '   Shopping Malls',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            SearchBar(hint: "Search",),
            MallsListWidget(),
          ],
        ),
      ),
    );
  }
}

class MallsListWidget extends StatefulWidget {
  @override
  _MallsListWidgetState createState() => _MallsListWidgetState();
}

class _MallsListWidgetState extends State<MallsListWidget> {
  MallsApi mallsApi = MallsApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mallsApi.fetchAllMalls(),
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
                return _buildMallList(snapshot.data);
                break;
              }
          }
          return Container();
        }
    );
  }
  Widget _buildMallList(List<ShoppingMall> malls){

    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: malls.length,
          itemBuilder: (BuildContext context, int index){
            return MallCard(
              mall: malls[index],
            );
          },
          //children: List.from(hotelCards)
        ),
      ),
    );
  }
}



