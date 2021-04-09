import 'package:graduation_project/models/user.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  User _user = new User();
  List<String> _cuisines = new List<String>();
  List<String> _cultures = new List<String>();
  List<String> _natures = new List<String>();

  User get user => _user;
  List<String> get cuisines => _cuisines;
  List<String> get natures => _natures;
  List<String> get cultures => _cultures;

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

  void addCuisine({String cuisine}){
    _cuisines.add(cuisine);
    notifyListeners();
  }

  void addCulture({String culture}){
    _cultures.add(culture);
    notifyListeners();
  }

  void addNature({String nature}){
    _natures.add(nature);
    notifyListeners();
  }

  void removeCuisine({String cuisine}){
    if(_cuisines.contains(cuisine)) _cuisines.remove(cuisine);
  }

  void removeCulture({String culture}){
    if(_cultures.contains(culture)) _cultures.remove(culture);
  }

  void removeNature({String nature}){
    if(_natures.contains(nature)) _natures.remove(nature);
  }



}