import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/models/place.dart';

class StatsWidget extends StatelessWidget {
  final double rate;

   StatsWidget({
    @required this.rate,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
        //buildStatistic('Followers', place.countFollowers),
        //buildStatistic('Posts', place.countPosts),
       // buildStatistic('Following', place.rating),
      _getStars(rate),
    )
    );


  // Widget buildStatistic( int value) => Column(
  //   mainAxisSize: MainAxisSize.min,
  //   children: _getStars(value);
  // );
 final List _listings = new List();

  List <Widget>_getStars(value) {
    List listings = List<Widget>();
    double i = 0;
    for (i = 0; i < rate-1; i++) {
      listings.add(
        Icon(
          Icons.star_rate,
            color: Colors.amber,
            size:36,
        ),
      );
    }
    if(rate==(i+0.5))
      listings.add(
        Icon(
          Icons.star_half,
          color: Colors.amberAccent,
          size:36,
        ),
      );
    for (i = 0; i < 4-(rate); i++) {
      listings.add(
        Icon(
          Icons.star_outline,
          color: Colors.amber,
          size:36,
        ),
      );
    }
    return listings;
  }
}
