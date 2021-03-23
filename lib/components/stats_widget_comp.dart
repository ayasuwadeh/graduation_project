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
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:rate!=-1?
      _getStars(rate):
          _getNoStars()
    )
    );


 final List _listings = new List();

  List <Widget>_getStars(double value) {
    List listings = List<Widget>();
    double i = 0;
    for (i = 0; i < value-1; i++) {
      listings.add(
        Icon(
          Icons.star_rate,
            color: Colors.amber,

            size:36,
        ),
      );
    }
    if(value==(i+0.5))
      {
        listings.add(
        Icon(
          Icons.star_half,
          color: Colors.amber,
          size:36,
        ),
      );
        i++;
      }
    else if(value==(i+1))
    {
      listings.add(
        Icon(
          Icons.star_rate,
          color: Colors.amber,
          size:36,
        ),
      );
      i++;
    }

    for (; i < 5; i++) {
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

  _getNoStars() {
    List listings = List<Widget>();

    for (int i=0; i < 5; i++) {
      listings.add(
        Icon(
          Icons.star_outline,
          color: Colors.grey,
          size:36,
        ),
      );
    }
   return listings;
  }
}
