import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:graduation_project/constants.dart';

class SearchBar extends StatefulWidget {
  final String hint;
  SearchBar({Key key, this.title, this.hint}) : super(key: key);
  final String title;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _suggestionsAutoTextController=new TextEditingController();
  List<String> suggestions = [
    "Apple",
    "Armidillo",
    "Soho Grand Hotel",
    "Arlo SoHo",
    "America",
    "Argentina",
    "Australia",
    "Antarctica",
    "Ten Ichi Market",
    "Cheese",
    "Danish",
    "Eclair",
    "Fudge",
    "Granola",
    "Haz elnut",
    "Ice Cream",
    "Jely",
    "Kiwi Fruit",
    "Lamb",
    "Macadamia",
    "Nachos",
    "Oatmeal",
    "Palm Oil",
    "Quail",
    "Rabbit",
    "Salad",
    "T-Bone Steak",
    "Urid Dal",
    "Vanilla",
    "Waffles",
    "Yam",
    "Zest"
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Padding(
        padding: EdgeInsets.only(left:size.width*0.073),
        child: Column(
          children: [
            Container(
              width: size.width*0.84,
              margin: EdgeInsets.only(bottom: size.width*0.02),
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
                    child: AutoCompleteTextField(
                        style: TextStyle(color: Colors.black,fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                            hintText: widget.hint+'...',
                            hintStyle: TextStyle(color: Colors.grey.shade700,fontSize:17,fontWeight: FontWeight.bold)
                        ),
                        clearOnSubmit: false,
                        controller: _suggestionsAutoTextController,
                        itemSubmitted:(item)
                        {
                          _suggestionsAutoTextController.text=item;
                        },
                        key: null,
                        suggestions: suggestions,
                        itemBuilder: (context,item)
                        {
                          return Container(
                            padding: EdgeInsets.all(25),
                            child: Row(
                              children: [
                                Text(
                                  item,
                                  style: TextStyle(color: Colors.black,
                                  ),
                                )

                              ],
                            ),
                          );
                        },
                        itemSorter: (a,b)
                        {
                          return a.compareTo(b);
                        },
                        itemFilter: (item,query)
                        {
                          return item.toLowerCase().startsWith(query.toLowerCase());
                        }),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.black.withAlpha(120),
                  ),

                ],
              ),
            )
          ],
        ),


    );
  }
}
