import 'package:flutter/material.dart';
import 'package:graduation_project/components/interests.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin {
  // TODO make data load only once

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              SizedBox(
                height: 26,
              ),
              Align(
                alignment: Alignment(0, 0),
                child: Text(
                  "getting to know better",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.8,
                ),
              ),
              const SizedBox(height: 20),
              Interests(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          "you can swipe left or right",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  bool get wantKeepAlive => true;
}
