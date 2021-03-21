import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth extends ChangeNotifier {
  bool _isAuthenticated = false;
  User _user;
  String _token;
  Map<String, String> _headers;

  bool get isAuthenticated  => _isAuthenticated;
  User get user => _user;

  final storage = new FlutterSecureStorage();

  Future<bool> login(Map creds) async {

    String tokenApi = ApiUtil.MAIN_API_UTIL + '/auth/login';
    Map<String, String> headers = {
      'accept': 'application/json'
    };

    creds['device_name'] = 'android';

    var response = await http.post(tokenApi, headers: headers, body: creds);
    if (response.statusCode == 200) {
      print(response.body.toString());
      saveToken(response.body);
      _token = response.body;
      setUserByToken(response.body);
      this._isAuthenticated = true;

    }else if(response.statusCode == 422){
      this._isAuthenticated = false;
      notifyListeners();
    }else{
      print(response.statusCode);
    }
    return _isAuthenticated;
  }

  Future<void> logout() async{
    String deleteTokenUrl = ApiUtil.MAIN_API_UTIL + '/auth/logout';

    await getToken().then((token) => setHeaders(token));

    //print(_token);

    var response = await http.post(deleteTokenUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      storage.delete(key: 'token');
      cleanup();
      notifyListeners();
      print('200');
    }
    else{
      print(response.statusCode);
    }
  }

  Future<void> setUserByToken(String token) async {
    if (token != null) {
      print(token);
      String getUserUrl = ApiUtil.MAIN_API_UTIL + '/user';
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(getUserUrl, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        this._user = User.fromJson(body);
        this._isAuthenticated = true;
        notifyListeners();
      } else {
        this._isAuthenticated = false;
        notifyListeners();
      }
    }else{
      this._isAuthenticated = false;
      notifyListeners();
    }
  }

  void saveToken(String token) async {
    storage.write(key: 'token', value: token);
  }

  Future<String> getToken() async {
    return storage.read(key: 'token');
  }

  void cleanup() {
    _isAuthenticated = false;
    _user = null;
    _token = null;
  }

  Future<bool> tryToken() async{

    return setUserByToken(await getToken()).then((val) => this.isAuthenticated? true : false);


  }

  setHeaders(String token) {
     _headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Map getHeaders(){
    return _headers;
  }

}
