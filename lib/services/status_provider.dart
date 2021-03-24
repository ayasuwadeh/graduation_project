import 'package:flutter/material.dart';


class StatusProvider with ChangeNotifier {
  bool _status;

  bool get status => _status;

  void setStatus({bool status, bool notify = true}) {
    _status = status;
    if(notify){
      notifyListeners();
    }
  }
}