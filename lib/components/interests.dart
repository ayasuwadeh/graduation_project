import 'package:flutter/material.dart';
import 'package:graduation_project/api/natures_api.dart';
import 'package:graduation_project/api/cuisines_api.dart';
import 'package:graduation_project/api/cultures_api.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/models/interest.dart';
import 'package:graduation_project/Screens/Recommendation/Choice.dart';
import 'package:graduation_project/Screens/Recommendation/card.dart';


class Interests extends StatefulWidget {
  final bool save;

  const Interests({Key key, this.save = true}) : super(key: key);
  @override
  _InterestsState createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  NatureApi natureApi = NatureApi();
  CuisineApi cuisineApi = CuisineApi();
  CultureApi cultureApi = CultureApi();

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }

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
            natureTitles.map((title) => Choice(innerText: title, type: 'nature', save: widget.save,)).toList()),
        CardN("What types of cuisines do like? ",
            cuisineTitles.map((title) => Choice(innerText: title,type: 'cuisine', save: widget.save,)).toList()),
        CardN("What types of cultures do like? ",
            culturesTitles.map((title) => Choice(innerText: title, type: 'culture', save: widget.save,)).toList()),
      ],
    );
  }

}
