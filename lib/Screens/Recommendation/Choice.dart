import 'package:flutter/material.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:provider/provider.dart';

class Choice extends StatefulWidget {
  final String innerText;
  final String type;

  Choice({this.innerText, this.type});
  ChoiceState createState() => ChoiceState();
}

class ChoiceState extends State<Choice> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: _selected,
      label: Text(widget.innerText),
      onSelected: (bool) {
        setState(() {
          _selected = !_selected;
          if(_selected){
            if(widget.type == 'cuisine'){
              Provider.of<UserProvider>(context, listen: false).addCuisine(cuisine: widget.innerText);
            }else if(widget.type == 'nature'){
              Provider.of<UserProvider>(context, listen: false).addNature(nature: widget.innerText);
            }else if(widget.type == 'culture'){
              Provider.of<UserProvider>(context, listen: false).addCulture(culture: widget.innerText);
            }
          }else if(!_selected){
            if(widget.type == 'cuisine'){
              Provider.of<UserProvider>(context, listen: false).removeCuisine(cuisine: widget.innerText);
            }else if(widget.type == 'nature'){
              Provider.of<UserProvider>(context, listen: false).removeNature(nature: widget.innerText);
            }else if(widget.type == 'culture'){
              Provider.of<UserProvider>(context, listen: false).removeCulture(culture: widget.innerText);
            }
          }
        });
      },
    );
  }
}
