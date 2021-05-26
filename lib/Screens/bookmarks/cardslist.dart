import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/bookmarks/date_divider.dart';
import 'package:graduation_project/Screens/bookmarks/card.dart';
import 'package:graduation_project/models/BookmarkPlace.dart';
class CardsList extends StatefulWidget {
  final List<BookmarkPlace> bookmarks;
  //final DateTime saved;

  const CardsList({Key key, this.bookmarks, }) : super(key: key);
  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  @override
  Widget build(BuildContext context) {
    return widget.bookmarks.length==0?
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 200,),
        Center(
          child: Text(
            "no bookmarks available ",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 22,
              //fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    ):
    SingleChildScrollView(
      child: Column(
        children: _createChildren( widget.bookmarks),
      ),
    );
  }
}

List<Widget> _createChildren(List<BookmarkPlace> list) {
  return new List<Widget>.generate(list.length, (int index) {
    return BookCard(
      place: list[index]
    );
  });
}


