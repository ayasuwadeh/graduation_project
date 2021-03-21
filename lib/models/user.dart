import 'locationUser.dart';
class User{
  String name;
  String email;
  String password;
  String token;
  String country;
  DateTime birthday;
  LocationUser location;

  User(this.name, this.email, this.password, this.token, this.country,
      this.birthday, this.location);

  User.fromJson(Map <String, dynamic> jsonObject){
    this.name = jsonObject['name'].toString();
    this.email = jsonObject['email'].toString();
    this.password = jsonObject['password'].toString();
    this.token = jsonObject['token'].toString();
    this.country = jsonObject['country'].toString();
    //this.birthday = jsonObject['birthday'];
    //this.location =  LocationUser.fromJson(jsonObject['location']);

  }

}
