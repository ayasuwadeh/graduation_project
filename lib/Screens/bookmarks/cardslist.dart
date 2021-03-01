import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/bookmarks/date_divider.dart';
import 'package:graduation_project/Screens/bookmarks/card.dart';

class CardsList extends StatefulWidget {
  final List<BookCard> cardsList;
  final DateTime saved;

  const CardsList({Key key, this.cardsList, this.saved}) : super(key: key);
  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

      ),
    );
  }
}
