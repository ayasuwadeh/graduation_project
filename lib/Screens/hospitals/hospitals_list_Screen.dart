import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/hospital.dart';
import 'package:graduation_project/constants.dart';
import 'hospital_card.dart';
import 'package:graduation_project/components/autocomplete_search_bar.dart';

class HospitalsListScreen extends StatelessWidget {
  List <Hospital> hospitals;
  HospitalsListScreen(this.hospitals);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return hospitals.length>0?Scaffold(
      appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.deepOrange,),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },),
          backgroundColor: Colors.white,
          title:
          Text("Hospitals", style: TextStyle(color: Colors.black87),)
      ),
      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HospitalsListWidget(hospitals),
          ],
        ),
      ),
    ):
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "no places around",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 22,
              //fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}

class HospitalsListWidget extends StatefulWidget {
  List <Hospital> hospitals;
 HospitalsListWidget(this.hospitals);
  @override
  _HospitalsListWidgetState createState() => _HospitalsListWidgetState();
}

class _HospitalsListWidgetState extends State<HospitalsListWidget> {
  List <Hospital> _searchedHospitals = new List <Hospital>();

  bool searchTapped=false;

  @override
  void initState() {
    _searchedHospitals = widget.hospitals;
    _searchedHospitals.sort((a, b) => a.location.distance.compareTo(b.location.distance));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {//TODO: bring data here from api
    return Expanded(child: _buildHospitalList(_searchedHospitals));
  }

  Widget searchBar() {//TODO:make it component
    Size size = MediaQuery
        .of(context)
        .size;

    return Padding(
      padding: EdgeInsets.only(left: size.width * 0),
      child: Column(
        children: [
          Container(
            width: size.width * 0.84,
           // margin: EdgeInsets.only(bottom: size.width * 0.02),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 22),
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    // key:_formKey,
                    style: TextStyle(color: Colors.black, fontSize: 20,
                    ),
                    decoration: new InputDecoration(
                        hintText: 'search...',
                        hintStyle: TextStyle(color: Colors.grey.shade700,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)
                    ),
                    onTap: ()
                    {
                      setState(() {
                        searchTapped=true;
                      });
                    },
                    onSubmitted:(string)
                    {
                      setState(() {
                        searchTapped=false;
                      });
                    },

                    onChanged: (text) {
                      text = text.toLowerCase();
                      setState(() {
                        _searchedHospitals = widget.hospitals.where((hotel) {
                          var hotelName = hotel.name.toLowerCase();
                          return hotelName.contains(text);
                        }).toList();
                      });
                    },
                  ),
                ),
                Icon(
                  Icons.search,
                  color: searchTapped?kPrimaryColor:Colors.black.withAlpha(120),
                ),

              ],
            ),
          )
        ],
      ),


    );
  }

  Widget _buildHospitalList(List<Hospital> hospitals) {
   // print(hospitals.length.toString());
    Size size = MediaQuery
        .of(context)
        .size;

    return  ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: hospitals.length+1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0)
            return searchBar();
          else
            return Transform(
              transform: Matrix4.translationValues(5, 0, 0),
                child:
                HospitalCard(hospital: hospitals[index -1],));
        }

    );
  }


}
