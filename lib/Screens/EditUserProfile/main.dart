import 'package:graduation_project/Screens/EditUserProfile/change_password_form.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/raisedbutton_text_icon.dart';
import 'edit_info_form.dart';
import 'change_email_form.dart';


class EditProfile extends StatefulWidget {
  EditProfile({
    Key key,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController country ;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final controller = ScrollController();



    void jumpTo() {
      controller.jumpTo(height * 0.4);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Edit profile",
            style: TextStyle(color: Colors.black87),
          )),
      body: ListView(
          controller: controller,
          children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                ImageContainer(path: "assets/icons/cockatoo.png"),
                SizedBox(
                  width: width * 0.2,
                ),
                RaisedButtonIconText(
                  text: "Edit interests",
                  icon: Icons.edit,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.015,
            ),
            EditInfoForm(),
            SizedBox(height: 10,),
            Container(width: width * 0.8, child: Divider(color: Colors.grey, thickness: 2 ,)),
            SizedBox(height: 10,),
            ChangePasswordForm(),
            SizedBox(height: 20,),
            Container(width: width * 0.8, child: Divider(color: Colors.grey, thickness: 2 ,)),
            SizedBox(height: 10,),
            ChangeEmail(),
            SizedBox(height: 20,),

          ],
        ),
      ]),
    );
  }
}
