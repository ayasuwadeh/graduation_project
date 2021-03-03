import 'package:flutter/cupertino.dart';
import 'package:graduation_project/components/countries_drop_down.dart';

import '../../constants.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [

        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: size.width * 0.7,
          height: 50,
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CountriesDropDown(),
        ),
      ],
    );
  }
}

