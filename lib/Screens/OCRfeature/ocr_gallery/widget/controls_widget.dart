import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedScanText;
  final VoidCallback onClickedClear;

  const ControlsWidget({
    @required this.onClickedPickImage,
    @required this.onClickedScanText,
    @required this.onClickedClear,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),

            child: FlatButton(
              onPressed: onClickedPickImage,
              child: Text('Pick Image',style: TextStyle(color: Colors.white),),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),

            child: FlatButton(
              onPressed: onClickedScanText,
              child: Text('Scan For Text',style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),

            child: FlatButton(
              onPressed: onClickedClear,
              child: Text('Clear',style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      );
}
