import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/components/interests.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/services/user_provider.dart';
import 'package:graduation_project/services/auth_provider.dart';

class EditInterests extends StatefulWidget {
  EditInterests({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditInterestsState createState() => _EditInterestsState();
}

class _EditInterestsState extends State<EditInterests> {

  int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            discard();
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "My Interests",
              style: TextStyle(color: Colors.black87),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
              // margin: EdgeInsets.only(top: 35),
              child: Column(
            children: [
              const SizedBox(height: 26),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Check and uncheck based on your interests",
                    style: GoogleFonts.lobsterTwo(
                        fontSize: 20, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Interests(save: false,),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 100),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      FlatButton(
                          onPressed: () {
                            discard();
                            setState(() {
                            });
                          },
                          child: Text(
                            "Discard Changes",
                            style: TextStyle(fontSize: 16),
                          )),
                      VerticalDivider(
                        thickness: 2,
                        width: 5,
                        color: Colors.black45,
                      ),
                      FlatButton(
                          onPressed: () {
                            Provider.of<UserProvider>(context, listen: false).setCuisinesFromTempCuisines();
                            Provider.of<UserProvider>(context, listen: false).setCulturesFromTempCultures();
                            Provider.of<UserProvider>(context, listen: false).setNaturesFromTempNatures();
                            sendRequests(context);
                          },
                          child: Text(
                            "Save Changes",
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  void sendRequests(BuildContext context) async {
    List<String> cuisines =
        Provider.of<UserProvider>(context, listen: false).cuisines;
    List<String> cultures =
        Provider.of<UserProvider>(context, listen: false).cultures;
    List<String> natures =
        Provider.of<UserProvider>(context, listen: false).natures;

    if(cuisines != null && cultures != null && natures != null ){
      final results = await Future.wait([
        Provider.of<AuthProvider>(context, listen: false).storeCultures(cultures: cultures),
        Provider.of<AuthProvider>(context, listen: false).storeCuisines(cuisines: cuisines),
        Provider.of<AuthProvider>(context, listen: false).storeNatures(natures: natures),
      ]);
      // success
      if(results[0]['status'] && results[1]['status'] && results[2]['status'])
      {
       // TODO dialog to tell user everything is done successfully
        print('success');
      }else{
        // TODO dialog to tell that sth is wrong
        print('error');
      }
    }else{
      // TODO dialog to tell that sth is empty
      print('sth is empty');
    }
  }

  void discard() {
    Provider.of<UserProvider>(context, listen: false).tempCuisines.clear();
    Provider.of<UserProvider>(context, listen: false).tempCultures.clear();
    Provider.of<UserProvider>(context, listen: false).tempNatures.clear();
    Provider.of<UserProvider>(context, listen: false).tempCuisines.addAll(
        Provider.of<UserProvider>(context, listen: false).cuisines);
    Provider.of<UserProvider>(context, listen: false).tempCultures.addAll(
        Provider.of<UserProvider>(context, listen: false).cultures);
    Provider.of<UserProvider>(context, listen: false).tempNatures.addAll(
        Provider.of<UserProvider>(context, listen: false).natures
    );
  }
}
