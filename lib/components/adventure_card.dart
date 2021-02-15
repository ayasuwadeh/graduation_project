import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Details/page/main_page.dart';

class AdventureCard extends StatelessWidget {
  final String text;
  final String image;

  const AdventureCard({Key key, this.text, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(
          builder: (context){
        return MainPage();
      }
        ));},
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: SizedBox(
          height: 250,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image(
                        image: AssetImage(image),
                        fit: BoxFit.fill)),
                Positioned.fill(
                    child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15)
                      ])),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text.rich(
                      TextSpan(style: TextStyle(color: Colors.white), children: [
                    TextSpan(
                        text: text + "\n",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
