import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/api/currency_exchange_api.dart';
import 'package:graduation_project/components/loading.dart';
import 'package:graduation_project/components/error.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/currency_exchange.dart';
import 'currency_exchange_card.dart';


class CurrencyExchangeListScreen extends StatelessWidget {
  List <CurrencyExchange> currencyEx;

  CurrencyExchangeListScreen( this.currencyEx);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.deepOrange,),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },),
          backgroundColor: Colors.white,
          title:
          Text("Currency Exchange", style: TextStyle(color: Colors.black87,fontSize: 22),)
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   margin: EdgeInsets.only(left: 29, top: 20, bottom: 20),
            //   child: Row(
            //     children: [
            //       InkWell(
            //           onTap: (){
            //             Navigator.pop(context);
            //           },
            //           child: Icon(
            //             Icons.arrow_back,
            //             color: kPrimaryColor,
            //             size: 30,
            //           )
            //       ),
            //       Text(
            //         '   Currency Exchange',
            //         style: TextStyle(
            //             fontSize: 30,
            //             fontWeight: FontWeight.bold
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            CurrencyExchangeListWidget(currencyEx),
          ],
        ),
      ),
    );
  }
}

class CurrencyExchangeListWidget extends StatefulWidget {
  List <CurrencyExchange> curr;

  CurrencyExchangeListWidget(this.curr);

  @override
  _CurrencyExchangeListWidgetState createState() => _CurrencyExchangeListWidgetState();
}

class _CurrencyExchangeListWidgetState extends State<CurrencyExchangeListWidget> {
//  CurrencyExchangeApi currencyExchangeApi = CurrencyExchangeApi();
@override
  void initState() {
    widget.curr.sort((a, b) => a.location.distance.compareTo(b.location.distance));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildHospitalList(widget.curr);
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
              currencyExc: currencyExchanges[index],
            );
          },
          //children: List.from(hotelCards)
        ),
      ),
    );
  }
}



