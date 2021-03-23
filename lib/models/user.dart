import 'locationUser.dart';

class User{
  int id;
  String name;
  String email;
  String password;
  String token;
  String country;
  DateTime birthday;
  LocationUser location;

  User({this.id, this.name, this.email, this.password, this.token, this.country,
      this.birthday, this.location});

  factory User.fromJson(Map <String, dynamic> jsonObject){
    return User(
      name: jsonObject['name'].toString(),
      email: jsonObject['email'].toString(),
      password: jsonObject['password'].toString(),
      token: jsonObject['token'].toString(),
      //country: jsonObject['country'].toString()
      //this.birthday = jsonObject['birthday'];
      //this.location =  LocationUser.fromJson(jsonObject['location']);
      // TODO fix
    );
  }

}
