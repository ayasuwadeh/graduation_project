import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class CountrySelector extends StatefulWidget {
   final String countryName;

   CountrySelector({Key key, this.countryName,}) : super(key: key);
  @override
  _CountrySelectorState createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  String countryValue="";
  String countryValue1="Select Your Country";
  @override
  Widget build(BuildContext context) {
    _showCountry() {
      setState(() {
        countryValue=countryValue1;
      });}
    @override
    initState()  {
      countryValue = widget.countryName;
      print("hi");
      super.initState();
    }

      return GestureDetector(

      child: Container(

          width: 330,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black45, width: 2),
            ),

          ),
          padding: const EdgeInsets.all(4),
          child: FlatButton(
              child: Row(
                  children:[ Icon(Icons.pin_drop_outlined,color: Colors.deepOrange,),
                    Text("  $countryValue",
                      style:TextStyle(color: Colors.black87,fontSize: 16),)]),
              onPressed: (){

                showCountryPicker(
                  context: context,

                  showPhoneCode: false, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    countryValue1= country.name;
                    //print(countryValue1);
                    _showCountry();


                  },
                );}
          )
      ),
    );


}}
