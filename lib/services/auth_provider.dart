import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  // TODO fix https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d

  Future<Map<String, dynamic>> login({String email, String password}) async {
    var result;

    Map<String, String> headers = {
      'accept': 'application/json'
    };

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
      'device_name' : 'ios'
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var response = await http.post(ApiUtil.login, headers: headers, body: loginData);

    if (response.statusCode == 200) {
      print('200');
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data']['user'];
      var token = responseData['data']['token'];
      print(token);
      User authUser = User.fromJson(userData);
      UserPreferences().saveUser(authUser, token);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};

    }else{
      print(response.statusCode);
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
        'error': json.decode(response.body)['errors'].toString()
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> logout() async{

    Future<Map<String, String>> headers = UserPreferences().getToken().then((token) => getHeadersForLogout(token));
    var response = await headers.then((value) => http.post(ApiUtil.logout, headers: value));

    var result;
    if (response.statusCode == 200) {
      UserPreferences().removeUser();
      _loggedInStatus = Status.LoggedOut;
      notifyListeners();
      result = { 'status': true };
    }
    else{
      result = {
        'status': false,
        'error': response.statusCode.toString()
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> signUp({String name, String email, String password, String passwordConfirmation}) async {
    var result;
    Map<String, String> headers = {
      'accept': 'application/json'
    };

    Map<String, String> registeredData = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    var response = await http.post(ApiUtil.signUp,
        headers: headers,
        body: registeredData);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data']['user'];
      var token = responseData['data']['token'];

      User authUser = User.fromJson(userData);
      UserPreferences().saveUser(authUser, token);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'user': authUser
      };

    }else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': 'Registration failed',
        'error': responseData['errors'].toString()
      };
    }
    return result;

  }

  Map<String, String> getHeadersForLogout(String token) {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return headers;
  }

}
