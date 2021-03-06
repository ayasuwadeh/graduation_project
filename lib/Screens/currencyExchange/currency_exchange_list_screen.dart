import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/api/currency_exchange_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/currency_exchange.dart';
import 'currency_exchange_card.dart';


class CurrencyExchangeListScreen extends StatelessWidget {

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
                    '   Currency Exchange',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            CurrencyExchangeListWidget(),
          ],
        ),
      ),
    );
  }
}

class CurrencyExchangeListWidget extends StatefulWidget {
  @override
  _CurrencyExchangeListWidgetState createState() => _CurrencyExchangeListWidgetState();
}

class _CurrencyExchangeListWidgetState extends State<CurrencyExchangeListWidget> {
  CurrencyExchangeApi currencyExchangeApi = CurrencyExchangeApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: currencyExchangeApi.fetchAllCurrencyExchange(),
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
                return _buildHospitalList(snapshot.data);
                break;
              }
          }
          return Container();
        }
    );
  }
  Widget _buildHospitalList(List<CurrencyExchange> currencyExchanges){

    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: currencyExchanges.length,
          itemBuilder: (BuildContext context, int index){
            return CurrencyExchangeCard(
              currencyExchange: currencyExchanges[index],
            );
          },
          //children: List.from(hotelCards)
        ),
      ),
    );
  }
}



