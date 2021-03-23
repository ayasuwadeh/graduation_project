import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Recommendation/Choice.dart';
import 'package:graduation_project/Screens/Recommendation/card.dart';
import 'package:graduation_project/api/natures_api.dart';
import 'package:graduation_project/api/cuisines_api.dart';
import 'package:graduation_project/api/cultures_api.dart';
import 'package:graduation_project/models/interest.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/components/loading.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin {
  // TODO make data load only once 
  NatureApi natureApi = NatureApi();
  CuisineApi cuisineApi = CuisineApi();
  CultureApi cultureApi = CultureApi();

  List<Choice> options;
  int id;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              SizedBox(
                height: 26,
              ),
              Align(
                alignment: Alignment(0, 0),
                child: Text(
                  "getting to know better",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.8,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment(.5, -7),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Wrap(
                          spacing: 8.0, // gap between adjacent chips
                          runSpacing: 15, // gap between lines
                          children: [
                            FutureBuilder(
                              future: Future.wait([
                                natureApi.fetchAllNatures(),
                                cuisineApi.fetchAllCuisines(),
                                cultureApi.fetchAllCultures(),
                              ]),
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
                                      return Error(errorText: snapshot.error.toString());
                                      break;
                                    } else if (snapshot.hasData) {
                                      return _drawInterests(
                                        context,
                                        snapshot.data[0],
                                        snapshot.data[1],
                                        snapshot.data[2],
                                      );
                                      break;
                                    }
                                }
                                return Container();
                              },
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          "you can swipe left or right",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  bool get wantKeepAlive => true;


  Widget _drawInterests(BuildContext context, List<Interest> natures, List<Interest> cuisines, List<Interest> cultures) {
    List<String> natureTitles = [];
    List<String> cuisineTitles = [];
    List<String> culturesTitles = [];

    for (var nature in natures) {
      natureTitles.add(nature.name);
    }
    for (var item in cuisines){
      cuisineTitles.add(item.name);
    }
    for(var culture in cultures){
      culturesTitles.add(culture.name);
    }

    return Column(
      children: [
        CardN("What types of sights do like? ",
            natureTitles.map((title) => Choice(title)).toList()),
        CardN("What types of cuisines do like? ",
            cuisineTitles.map((title) => Choice(title)).toList()),
        CardN("What types of cultures do like? ",
            culturesTitles.map((title) => Choice(title)).toList()),
      ],
    );
  }
}
