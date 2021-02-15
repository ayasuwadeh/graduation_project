import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Hotels/list_screen.dart';

import '../../constants.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List <Map<String, dynamic>> categories = [
      {"icon" : Icons.hotel, "text": "Hotels", "route": ListScreen(label: "Hotels")},
      {"icon" : Icons.store_mall_directory, "text": "Super Markets", "route": ListScreen(label: "Super Markets",)},
      {"icon" : Icons.local_mall, "text": "Malls", "route": ListScreen(label: "Malls",)},
      {"icon" : Icons.attach_money, "text": "Currency Exch.", "route": ListScreen(label: "Currency Exchange",)},
      {"icon" : Icons.local_hospital, "text": "Hospitals", "route": ListScreen(label: "Hospitals",)},
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ...List.generate(categories.length, (index) =>
            CategorieCard(
              icon: categories[index]["icon"],
              label: categories[index]["text"],
              press: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return categories[index]["route"];
                    }
                ));
              },
            ),
        )
      ],
    );
  }
}

class CategorieCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final GestureTapCallback press;

  const CategorieCard({Key key, this.label, this.icon, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: SizedBox(
        width: 60,
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFECDF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: kPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54
              ),
            )
          ],
        ),
      ),
    );
  }
}