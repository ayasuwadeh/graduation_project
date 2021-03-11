
import 'package:graduation_project/api/Language.dart';
import 'package:flutter/material.dart';
import 'translator_text_area.dart';
import 'package:translator/translator.dart';

class Translator extends StatefulWidget {
  final VoidCallback onClickedCopy;

  final BuildContext context;
  final String text;
  const Translator({Key key, this.context, this.text, this.onClickedCopy}) : super(key: key);

  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  List<Language> _languages = Language.getLanguages();
  List<DropdownMenuItem<Language>> _dropdownMenuItems;
  Language _selectedLanguage;
  final translator = GoogleTranslator();
  var translatedText;
  var t;
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_languages);
    _selectedLanguage = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Language>> buildDropdownMenuItems(List languages) {
    List<DropdownMenuItem<Language>> items = List();
    for (Language language in languages) {
      items.add(
        DropdownMenuItem(
          value: language,
          child: Text(language.name),
        ),
      );
    }
    return items;
  }
  onChangeDropdownItem(Language selectedLanguage) {
    setState(() {
      _selectedLanguage = selectedLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                  ),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Translator",
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center
                          ),
                          SizedBox(width: width*0.47,),
                          IconButton(
                            icon: Icon(Icons.close, size: 35,),

                            onPressed: () {
                              Navigator.pop(context);

                            },
                          )

                        ],
                      ),
                      SizedBox(height: height*0.001,),
                      Row(
                        children: [
                          Text("  To",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                          ),
                          SizedBox(width: width*0.1,),
                          DropdownButton(
                            value: _selectedLanguage,
                            items: _dropdownMenuItems,
                            onChanged: onChangeDropdownItem,
                          ),
                          SizedBox(width: width*0.1,),

                             IconButton(
                               iconSize: 45,
                              icon: Icon(Icons.arrow_circle_down_outlined,
                                  color: Colors.deepOrangeAccent),
                              color: Colors.grey[200],
                              onPressed: translate,
                            ),

                        ],
                      ),
                     // SizedBox(height: height*0.001,),
                      TextAreaWidget(text:
                      translatedText==null?" ":translatedText.toString(),
                          onClickedCopy: widget.onClickedCopy)

                    ],
                  )
              ),

            ],
          )
      );

    }

  void translate() async {

       await translator.translate(widget.text,
          to: _selectedLanguage.code).then((value) => {
       setState(() {
       translatedText=value;
       })

       });



  }

}
