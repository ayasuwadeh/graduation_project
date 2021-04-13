import 'package:flutter/material.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:provider/provider.dart';

class Choice extends StatefulWidget {
  final String innerText;
  final String type;
  final bool save;

  // save is false in order to use choices in edit interests screen
  // when user selects a choice in edit screen, that choice is saved in a temporary list not the original one.

  Choice({this.innerText, this.type, this.save = true});
  ChoiceState createState() => ChoiceState();
}

class ChoiceState extends State<Choice> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    if(widget.type == 'cuisine')
      _selected = Provider.of<UserProvider>(context, listen: false).tempCuisines.contains(widget.innerText);
    else if (widget.type == 'culture')
      _selected = Provider.of<UserProvider>(context, listen: false).tempCultures.contains(widget.innerText);
    else if(widget.type == 'nature')
      _selected = Provider.of<UserProvider>(context, listen: false).tempNatures.contains(widget.innerText);


    return ChoiceChip(
      selected: _selected,
      label: Text(widget.innerText),
      onSelected: (bool) {
        setState(() {
          _selected = !_selected;
          if(widget.save) {
            if (_selected) {
              if (widget.type == 'cuisine') {
                Provider.of<UserProvider>(context, listen: false).addCuisine(
                    cuisine: widget.innerText);
              } else if (widget.type == 'nature') {
                Provider.of<UserProvider>(context, listen: false).addNature(
                    nature: widget.innerText);
              } else if (widget.type == 'culture') {
                Provider.of<UserProvider>(context, listen: false).addCulture(
                    culture: widget.innerText);
              }
            } else if (!_selected) {
              if (widget.type == 'cuisine') {
                Provider.of<UserProvider>(context, listen: false).removeCuisine(
                    cuisine: widget.innerText);
              } else if (widget.type == 'nature') {
                Provider.of<UserProvider>(context, listen: false).removeNature(
                    nature: widget.innerText);
              } else if (widget.type == 'culture') {
                Provider.of<UserProvider>(context, listen: false).removeCulture(
                    culture: widget.innerText);
              }
            }
          } else {
            if (_selected) {
              if (widget.type == 'cuisine') {
                Provider.of<UserProvider>(context, listen: false).addTempCuisine(
                    cuisine: widget.innerText);
              } else if (widget.type == 'nature') {
                Provider.of<UserProvider>(context, listen: false).addTempNature(
                    nature: widget.innerText);
              } else if (widget.type == 'culture') {
                Provider.of<UserProvider>(context, listen: false).addTempCulture(
                    culture: widget.innerText);
              }
            } else if (!_selected) {
              if (widget.type == 'cuisine') {
                Provider.of<UserProvider>(context, listen: false).removeTempCuisine(
                    cuisine: widget.innerText);
              } else if (widget.type == 'nature') {
                Provider.of<UserProvider>(context, listen: false).removeTempNature(
                    nature: widget.innerText);
              } else if (widget.type == 'culture') {
                Provider.of<UserProvider>(context, listen: false).removeTempCulture(
                    culture: widget.innerText);
              }
            }
          }
        });
      },
    );
  }
}
