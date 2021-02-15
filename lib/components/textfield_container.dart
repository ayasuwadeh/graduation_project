import 'package:flutter/material.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Border errorBorder;

  const TextFieldContainer({
    Key key, this.child, this.errorBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: child,
    );
  }
}
