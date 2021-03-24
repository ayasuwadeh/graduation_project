import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
class SearchBar extends StatefulWidget {
 final VoidCallback onTapped;
 final Function onChanged;
 final VoidCallback onSubmitted;
 final bool searchTapped;

  const SearchBar({Key key, this.onTapped, this.onChanged, this.onSubmitted, this.searchTapped}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {

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
                      onTap: widget.onTapped,
                      onSubmitted:(txt)=>widget.onSubmitted,
                      onChanged: (txt)=>widget.onChanged,
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: widget.searchTapped?kPrimaryColor:Colors.black.withAlpha(120),
                  ),

                ],
              ),
            )
          ],
        ),


      );
    }
  }

