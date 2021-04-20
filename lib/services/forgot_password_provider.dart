import 'package:flutter/material.dart';


class ForgotPasswordProvider extends ChangeNotifier{
  String _email;
  String _token;

  String get token => _token;
  String get email => _email;

  void setEmail(String value) {
    _email = value;
    //notifyListeners();
  }

  void setToken(String token){
    _token = token;
  }
}