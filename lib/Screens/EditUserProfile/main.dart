import 'package:graduation_project/Screens/EditUserProfile/widgets/image_container.dart';
import 'file:///C:/Users/Msys/AndroidStudioProjects/edit_profile/lib/widgets/underliened_passwordfield.dart';
import 'file:///C:/Users/Msys/AndroidStudioProjects/edit_profile/lib/widgets/underlined_textField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/raisedbutton_text_icon.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/country_selector.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/Date_selector.dart';
import 'package:graduation_project/Screens/EditUserProfile/widgets/save_discard.dart';
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           colorScheme:ColorScheme.light().copyWith(
//             primary: Colors.deepOrange,
//           ),),
//       home: EditProfile(),
//     );
//   }
// }

class EditProfile extends StatefulWidget {
  EditProfile({Key key, }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final controller=ScrollController();
    void jumpTo()
    {
      controller.jumpTo(height*0.4);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(icon:Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
          Navigator.pop(context);
          },),
          title:Text("Edit profile", style: TextStyle(color: Colors.black87),)

      ),
      body: ListView(
        controller: controller,
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: height*0.01,),
            Row(
              children: [
                ImageContainer(path:"assets/icons/cockatoo.png"),
                SizedBox(width: width*0.2,),
                RaisedButtonIconText(
                  text: "Edit interests",
                  icon: Icons.edit,
                ),
              ],
            ),
            SizedBox(height: height*0.015,),
            UnderlinedTextFormField(
              icon: Icons.person_outline,
              text: "Aya Suwadeh",
            ),
            SizedBox(height: 18,),
            UnderlinedTextFormField(
              icon: Icons.email_outlined,
              text: "ayafrhn@gmail.com",
            ),

            ///////////////country
          CountrySelector(countryName: "palestine",),
            ///////////////birthday
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left: width*0.1),
              child: Align(
                alignment: Alignment.topLeft,
                  child: Text("My Birthday is:",style: TextStyle(fontSize: 16),)),
            ),
            DateSelector(initialDate: new DateTime(2020, 10, 08),),

            InkWell(
              onTap: (){
                //print("hi");
              jumpTo();
              },
              child: Container(
                padding: EdgeInsets.only(left: width*0.05),
                child: Row(
                  children: [
                    Text("Change My Password",style: GoogleFonts.lobsterTwo(
                    fontSize: 20, color: Colors.black87
                  ),
                ),
                    SizedBox(width: width*0.45,),
                    Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.black54,
                        size: 35,)
                  ]
                ),
              ),
            ),
            UnderlinedPasswordField(
              hintText: "Current Password",
            ),
            UnderlinedPasswordField(
              hintText: "New Password",
            ),
            UnderlinedPasswordField(
              hintText: "Confirm Password",
            ),
            SizedBox(height: height*0.06,),

           Options(
             option1:"Discard Changes",
             option2:"save Changes",
           ),



          ],

        ),
      ]),
    );
  }
}
