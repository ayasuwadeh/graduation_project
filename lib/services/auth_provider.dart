import 'package:flutter/cupertino.dart';
import 'package:graduation_project/api/api_util.dart';
import 'package:graduation_project/models/story-image.dart';
import 'package:graduation_project/models/user-story.dart';
import 'package:graduation_project/models/user.dart';
import 'package:graduation_project/services/user_preferences.dart';
import 'package:graduation_project/models/path-point.dart';
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

enum ForgotPasswordSendCodeStatus {
  NotSent,
  Sending,
  Sent
}

enum PasswordCodeCheck {
  NotSent,
  Sending,
  Sent
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  ForgotPasswordSendCodeStatus _codeStatus = ForgotPasswordSendCodeStatus.NotSent;
  PasswordCodeCheck _codeCheck = PasswordCodeCheck.NotSent;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  ForgotPasswordSendCodeStatus get codeStatus => _codeStatus;
  PasswordCodeCheck get codeCheck => _codeCheck;


  Future<Map<String, dynamic>> login({String email, String password}) async {
    var result;

    Map<String, String> headers = {'accept': 'application/json'};

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
      'device_name': 'ios'
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var response =
        await http.post(ApiUtil.login, headers: headers, body: loginData);

    if (response.statusCode == 200) {
      print('200');
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data']['user'];
      var token = responseData['data']['token'];
      print(token);
      User authUser = User.fromJson(userData);
      print(authUser.birthday);
      UserPreferences().saveUser(authUser);
      UserPreferences().saveToken(token);
      UserPreferences().setStatusLogIn();
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
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

  Future<Map<String, dynamic>> logout() async {
    Future<Map<String, String>> headers =
        UserPreferences().getToken().then((token) => getHeaders(token));
    var response = await headers
        .then((value) => http.post(ApiUtil.logout, headers: value));

    var result;
    if (response.statusCode == 200) {
      UserPreferences().removeUser();
      UserPreferences().setStatusLogOut();
      _loggedInStatus = Status.LoggedOut;
      notifyListeners();
      result = {'status': true};
    } else {
      UserPreferences().removeUser();
      UserPreferences().setStatusLogOut();
      _loggedInStatus = Status.LoggedOut;
      notifyListeners();
      result = {'status': false, 'error': response.statusCode.toString()};
    }
    return result;
  }

  Future<Map<String, dynamic>> signUp(
      {String name,
      String email,
      String password,
      String passwordConfirmation}) async {
    var result;
    Map<String, String> headers = {'accept': 'application/json'};

    Map<String, String> registeredData = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    var response =
        await http.post(ApiUtil.signUp, headers: headers, body: registeredData);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data']['user'];
      var token = responseData['data']['token'];

      User authUser = User.fromJson(userData);
      UserPreferences().saveUser(authUser);
      UserPreferences().saveToken(token);
      UserPreferences().setStatusLogIn();

      _registeredInStatus = Status.Registered;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successfully registered',
        'user': authUser
      };
    } else {
      _registeredInStatus = Status.NotRegistered;
      notifyListeners();
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': 'Registration failed',
        'error': responseData['errors'].toString()
      };
    }
    return result;
  }

  Map<String, String> getHeaders(String token) {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return headers;
  }

  Future<Map<String, dynamic>> sendCountryAndBirthday(
      String country, DateTime birthday) async {
    Map<String, dynamic> data = {
      'country': country,
      'birthday': birthday.toString()
    };

    Future<Map<String, String>> headers =
        UserPreferences().getToken().then((token) => getHeaders(token));
    var response = await headers.then((value) => http.post(
        ApiUtil.countryAndBirthday + '?_method=put',
        headers: value,
        body: data));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var country = responseData['data']['country'];
      var birthday = responseData['data']['birthday'];
      UserPreferences().setCountry(country);
      UserPreferences().setBirthday(birthday);
      Map<String, dynamic> data = {
        'status': true,
      };
      print('country' + response.statusCode.toString());
      return data;
    } else {
      Map<String, dynamic> data = {
        'status': false,
      };
      print('country' + response.statusCode.toString());
      return data;
    }
  }

  Future<Map<String, dynamic>> editInfo(
      {String name, String country, String birthday}) async {
    Map<String, dynamic> data = {
      'name': name,
      'country': country,
      'birthday': birthday
    };

    Future<Map<String, String>> headers =
        UserPreferences().getToken().then((token) => getHeaders(token));
    var response = await headers.then((value) => http
        .post(ApiUtil.editInfo + '?_method=put', headers: value, body: data));
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var user = responseData['data']['user'];
      User authUser = User.fromJson(user);
      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully changed info',
        'user': authUser
      };
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': 'Failed',
        'error': responseData['errors'].toString()
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> changeEmail({String email}) async {
    Map<String, dynamic> data = {
      'email': email,
    };

    Future<Map<String, String>> headers =
        UserPreferences().getToken().then((token) => getHeaders(token));
    var response = await headers.then((value) => http.post(
        ApiUtil.changeEmail + '?_method=put',
        headers: value,
        body: data));
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var user = responseData['data']['user'];
      User authUser = User.fromJson(user);
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully changed info',
        'user': authUser
      };
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': 'Failed',
        'error': responseData['errors']['email'].toString()
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> changePassword(
      {String currentPassword,
      String newPassword,
      String newPasswordConfirmation}) async {
    Map<String, dynamic> data = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation
    };

    Future<Map<String, String>> headers =
        UserPreferences().getToken().then((token) => getHeaders(token));
    var response = await headers.then((value) =>
        http.post(ApiUtil.changePassword, headers: value, body: data));
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var user = responseData['data']['user'];
      User authUser = User.fromJson(user);
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully changed info',
        'user': authUser
      };
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': 'Failed',
        'error': responseData['errors']['current_password'].toString()
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> storeCuisines({List<String> cuisines}) async {
    Map<String, dynamic> data = {'cuisines': cuisines};

    final body = jsonEncode(data);

    Future<Map<String, String>> headers = UserPreferences()
        .getToken()
        .then((token) => getHeadersForJsonContent(token));
    var response = await headers.then((value) =>
        http.post(ApiUtil.storeCuisines, headers: value, body: body));
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<String> cuisines = List<String>();
      for (var item in responseData['data']) {
        //print(item['name']);
        cuisines.add(item['name'].toString());
      }

      UserPreferences().saveCultures(cuisines);

      result = {
        'status': true,
        'message': 'Successfully changed info',
      };
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': 'Failed',
        'error': responseData['errors'].toString()
      };
    }
    print('cuisines' + response.statusCode.toString());
    return result;
  }

  Future<Map<String, dynamic>> storeCultures({List<String> cultures}) async {
    Map<String, dynamic> data = {'cultures': cultures};

    final body = jsonEncode(data);
    Future<Map<String, String>> headers = UserPreferences()
        .getToken()
        .then((token) => getHeadersForJsonContent(token));
    var response = await headers.then((value) =>
        http.post(ApiUtil.storeCultures, headers: value, body: body));
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<String> cultures = List<String>();
      for (var item in responseData['data']) {
        cultures.add(item['name'].toString());
      }
      UserPreferences().saveCultures(cultures);

      result = {
        'status': true,
        'message': 'Successfully changed info',
      };
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': 'Failed',
        'error': responseData['errors'].toString()
      };
    }
    //print('cultures' + response.statusCode.toString());
    return result;
  }

  Future<Map<String, dynamic>> storeNatures({List<String> natures}) async {
    Map<String, dynamic> data = {'natures': natures};

    final body = jsonEncode(data);

    Future<Map<String, String>> headers = UserPreferences()
        .getToken()
        .then((token) => getHeadersForJsonContent(token));
    var response = await headers.then(
        (value) => http.post(ApiUtil.storeNatures, headers: value, body: body));
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<String> natures = List<String>();
      for (var item in responseData['data']) {
        natures.add(item['name']);
      }

      UserPreferences().saveNatures(natures);

      result = {
        'status': true,
        'message': 'Successfully changed info',
      };
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': 'Failed',
        'error': responseData['errors'].toString()
      };
    }
    //print('natures' + response.statusCode.toString());
    return result;
  }

  Map<String, String> getHeadersForJsonContent(String token) {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
      'content-type': 'application/json'
    };
    return headers;
  }

  Future<Map<String, dynamic>> sendForgotPasswordEmail({String email}) async {
    Map<String, dynamic> data = {
      'email': email,
    };

    Map<String, String> headers = {'Accept': 'Application/json'};
    _codeStatus = ForgotPasswordSendCodeStatus.Sending;
    var response = await http.post(ApiUtil.sendResetPasswordCode,
        headers: headers, body: data);
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var error = responseData['error'];
      var message = responseData['message'];

      result = {
        'errorStatus': error,
        'message': message
      };

    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var error = responseData['error'];
      var message = responseData['message'];

      result = {
        'errorStatus': error,
        'message': message
      };
    }
    _codeStatus = ForgotPasswordSendCodeStatus.Sent;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> validatePasswordResetToken({String email, String code}) async {
    Map<String, dynamic> data = {
      'email': email,
      'password_reset_code': code
    };

    Map<String, String> headers = {'Accept': 'Application/json'};

    _codeCheck = PasswordCodeCheck.Sending;
    notifyListeners();

    var response = await http.post(ApiUtil.validatePasswordResetToken,
        headers: headers, body: data);
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var error = responseData['error'];
      var message = responseData['message'];
      var token = responseData['token'];

      result = {
        'errorStatus': error,
        'message': message,
        'token' : token
      };

    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var error = responseData['error'];
      var message = responseData['message'];

      result = {
        'errorStatus': error,
        'message': message
      };
    }
    _codeCheck = PasswordCodeCheck.Sent;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> resetPassword({String email, String token, String password, String passwordConfirmation}) async {
    Map<String, String> data = {
      'email': email,
      'password_token': token,
      'password': password,
      'password_confirmation': passwordConfirmation
    };

    Map<String, String> headers = {'Accept': 'Application/json'};


    var response = await http.post(ApiUtil.resetPassword,
        headers: headers, body: data);
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var error = responseData['error'];
      var message = responseData['message'];
      var user = responseData['user'];
      User authUser = User.fromJson(user);

      result = {
        'errorStatus': error,
        'message': message,
        'user' : authUser
      };

    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var error = responseData['error'];
      var message = responseData['message'];

      result = {
        'errorStatus': error,
        'message': message
      };
    }
    return result;
  }


  Future<Map<String, dynamic>> saveStory({UserStory story, List<StoryImage> images, List<PathPoint> points}) async {
    Map<String, dynamic> data = {
      'name': story.name,
      'city': story.city,
      'country': story.country,
      'images': jsonEncode(images),
      //'points': points.toString()
    };
    final body = jsonEncode(data);

    print(body.toString());

    Future<Map<String, String>> headers = UserPreferences()
        .getToken()
        .then((token) => getHeadersForJsonContent(token));


    var response = await headers.then((header) => http.post(ApiUtil.saveStory,
        headers: header, body: body));

    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if(responseData['success']){
        result = {
          'success': true,
          'story': story,
          'images': images,
          'points': points
        };
      }else{
        result = {
          'success': false,
        };
      }
    } else {
      print(response.statusCode);
      result = {
        'success': false,
      };
    }
    return result;
  }


}
