import 'package:flutter/material.dart';

class TextAreaWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClickedCopy;

  const TextAreaWidget({
    @required this.text,
    @required this.onClickedCopy,
    Key key,
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
              margin: EdgeInsets.only(left: 1,top: 20),
              height: height*0.33,
              width: width*0.84,
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
              margin: EdgeInsets.only(left: 10,top: 20),

              child: IconButton(
                icon: Icon(Icons.copy, color: Colors.black),
                color: Colors.grey[200],
                onPressed: onClickedCopy,
              ),
            ),

          ],
        ),
        // const SizedBox(width: 8),
      ],
    );
  }

}
