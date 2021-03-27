import 'package:graduation_project/models/user.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser({User user, bool notify = true}) {
    _user = user;
    if(notify){
      notifyListeners();
    }
  }

  void setUserCountry ({String country}){
    this._user.country = country;
    notifyListeners();
  }

  void setUserBirthday({DateTime birthday}){
    this._user.birthday = birthday;
    notifyListeners();
  }

}