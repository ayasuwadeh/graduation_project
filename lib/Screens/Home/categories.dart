import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Hotels/hotels_list_screen.dart';
import 'package:graduation_project/Screens/hospitals/hospitals_list_Screen.dart';
import 'package:graduation_project/Screens/malls/malls_list_screen.dart';
import 'package:graduation_project/Screens/currencyExchange/currency_exchange_list_screen.dart';
import 'package:graduation_project/Screens/markets/markets_list_screen.dart';

import '../../constants.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List <Map<String, dynamic>> categories = [
      {"icon" : Icons.hotel, "text": "Hotels", "route": HotelsListScreen()},
      {"icon" : Icons.store_mall_directory, "text": "Super Markets", "route": MarketsListScreen()},
      {"icon" : Icons.local_mall, "text": "Malls", "route": MallsListScreen()},
      {"icon" : Icons.attach_money, "text": "Currency Exch.", "route": CurrencyExchangeListScreen()},
      {"icon" : Icons.local_hospital, "text": "Hospitals", "route": HospitalsListScreen()},
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