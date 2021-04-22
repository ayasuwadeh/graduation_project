import 'package:graduation_project/models/user.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  User _user = new User();
  List<String> _cuisines = new List<String>();
  List<String> _cultures = new List<String>();
  List<String> _natures = new List<String>();

  List<String> _tempCuisines = new List<String>();
  List<String> _tempCultures = new List<String>();
  List<String> _tempNatures = new List<String>();

  User get user => _user;
  List<String> get cuisines => _cuisines;
  List<String> get natures => _natures;
  List<String> get cultures => _cultures;
  List<String> get tempCultures => _tempCultures;
  List<String> get tempNatures => _tempNatures;
  List<String> get tempCuisines => _tempCuisines;


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
    _tempCuisines.add(cuisine);
    notifyListeners();
  }

  void addCulture({String culture}){
    _cultures.add(culture);
    _tempCultures.add(culture);
    notifyListeners();
  }

  void addNature({String nature}){
    _natures.add(nature);
    _tempNatures.add(nature);
    notifyListeners();
  }

  void removeCuisine({String cuisine}){
    if(_cuisines.contains(cuisine)) {
      _cuisines.remove(cuisine);
      _tempCuisines.remove(cuisine);
    }
  }

  void removeCulture({String culture}){
    if(_cultures.contains(culture)) {
      _cultures.remove(culture);
      _tempCultures.remove(culture);
    }
  }

  void removeNature({String nature}){
    if(_natures.contains(nature)) {
      _natures.remove(nature);
      _tempNatures.remove(nature);
    }
  }

  void addTempCuisine({String cuisine}){
    _tempCuisines.add(cuisine);
    notifyListeners();
  }

  void addTempCulture({String culture}){
    _tempCultures.add(culture);
    notifyListeners();
  }

  void addTempNature({String nature}){
    _tempNatures.add(nature);
    notifyListeners();
  }

  void removeTempCuisine({String cuisine}){
    if(_tempCuisines.contains(cuisine)) _tempCuisines.remove(cuisine);
  }

  void removeTempCulture({String culture}){
    if(_tempCultures.contains(culture)) _tempCultures.remove(culture);
  }

  void removeTempNature({String nature}){
    if(_tempNatures.contains(nature)) _tempNatures.remove(nature);
  }

  void setCuisinesFromTempCuisines(){
    _cuisines.clear();
    _cuisines.addAll(_tempCuisines);
  }

  void setCulturesFromTempCultures(){
    _cultures.clear();
    _cultures.addAll(_tempCultures);
  }

  void setNaturesFromTempNatures(){
    _natures.clear();
    _natures.addAll(_tempNatures);
  }

  deleteData() {
    _cuisines.clear();
    _natures.clear();
    _cultures.clear();
    _tempNatures.clear();
    _tempCultures.clear();
    _tempCuisines.clear();
  }

}