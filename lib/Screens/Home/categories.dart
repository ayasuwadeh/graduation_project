import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Hotels/hotels_list_screen.dart';
import 'package:graduation_project/Screens/hospitals/hospitals_list_Screen.dart';
import 'package:graduation_project/Screens/malls/malls_list_screen.dart';
import 'package:graduation_project/Screens/currencyExchange/currency_exchange_list_screen.dart';
import 'package:graduation_project/Screens/markets/markets_list_screen.dart';
import 'package:graduation_project/api/hotels_api.dart';
import 'package:graduation_project/api/markets_api.dart';
import 'package:graduation_project/api/malls_api.dart';
import 'package:graduation_project/api/currency_exchange_api.dart';
import 'package:graduation_project/api/hospitals_api.dart';

import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/models/hotel.dart';
import 'package:graduation_project/models/market.dart';

import '../../constants.dart';

class Categories extends StatelessWidget {
  List <Hotel> hotels;
  List <Market> markets;

  HotelApi hotelApi = HotelApi();
  MarketsApi marketsApi = MarketsApi();
  MallsApi mallApi = MallsApi();
  CurrencyExchangeApi currencyExcApi = CurrencyExchangeApi();
  HospitalApi hospitalApi = HospitalApi();


  @override
  Widget build(BuildContext context) {
    List <Map<String, dynamic>> categories = [
      {"icon": Icons.hotel,
        "text": "Hotels",
        "api":hotelApi.fetchAllHotels()},
      {
        "icon": Icons.store_mall_directory,
        "text": "Super Markets",
        "api":marketsApi.fetchAllMarkets()
      },
      {
        "icon": Icons.local_mall,
        "text": "Malls",
        "api":mallApi.fetchAllMalls()

      },
      {
        "icon": Icons.attach_money,
        "text": "Currency Exch.",
        "api":currencyExcApi.fetchAllCurrencyExchange()


      },
      {
        "icon": Icons.local_hospital,
        "text": "Hospitals",
        "api":hospitalApi.fetchAllHospitals()

      },
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
            press: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FutureBuilder(
                        future: categories[index]["api"],
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
                                return Error(errorText: snapshot.error
                                    .toString());
                                break;
                              }
                              else if (snapshot.hasData) {
                                {print(snapshot.data);
                                  switch( index)
                                  {
                                  case 0:
                                    {
                                      return HotelsListScreen(snapshot.data);
                                    }
                                    break;
                                  case 1:
                                    {
                                      return MarketsListScreen(snapshot.data);
                                    }
                                    break;
                                  case 2:
                                    {
                                      return MallsListScreen(snapshot.data);
                                    }
                                    break;
                                  case 3:
                                    {
                                     return CurrencyExchangeListScreen(snapshot.data);
                                    }
                                    break;
                                  case 4:
                                    {
                                      return HospitalsListScreen(snapshot.data);

                                    }

                                    break;
                                }
                                }
                              }
                          }
                          return Container(color: Colors.white,);
                        }
                    );
                  }));
            }
        )
    )

  ]

  ,

  );
}}

class CategorieCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final GestureTapCallback press;

  const CategorieCard({Key key, this.label, this.icon, this.press})
      : super(key: key);

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