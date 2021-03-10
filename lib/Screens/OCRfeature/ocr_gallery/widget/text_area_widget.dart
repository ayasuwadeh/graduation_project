import 'package:flutter/material.dart';
import 'translator.dart';
class TextAreaWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClickedCopy;
  final Widget buildTranslator;

  const TextAreaWidget({
    @required this.text,
    @required this.onClickedCopy,
    Key key, this.buildTranslator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    return Row(

      children: [
        Stack(
          children: [
               Container(
                height: 280,
                width: width*0.95,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),

                ),
                //padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: SelectableText(
                  text.isEmpty ? 'Scan an Image to get text' : text,
                  textAlign: TextAlign.center,
                ),
              ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  shape: BoxShape.circle
              ),

              child: IconButton(
                icon: Icon(Icons.copy, color: Colors.white),
                color: Colors.grey[200],
                onPressed: onClickedCopy,
              ),
            ),
            Positioned(
              //alignment: Alignment.topRight,
              top: width*0.15,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    shape: BoxShape.circle
                ),

                child: IconButton(
                  icon: Icon(Icons.g_translate, color: Colors.white),
                  color: Colors.grey[200],
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Translator(context:context,
                      text: this.text,),
                    );
                  },

                ),
              ),
            ),


          ],
        ),
        // const SizedBox(width: 8),
      ],
    );


  }

}
