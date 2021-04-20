import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
