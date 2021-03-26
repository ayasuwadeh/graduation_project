import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation_project/models/user.dart';


class UserPreferences {

  Future<bool> saveUser(User user, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   // SharedPreferences.setMockInitialValues({});

    prefs.setInt("userId", user.id);
    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("token", token);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId");
    String name = prefs.getString("name");
    String email = prefs.getString("email");
    String token = prefs.getString("token");

    //print('userId: ' + userId.toString() + ' name: ' + name + ' email: ' + email + ' token: ' + token);

    return User(
        id: userId,
        name: name,
        email: email,
        token: token,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("token");
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }

  Future<bool> setStatusLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Status', true);
    return prefs.commit();
  }

  Future<bool> setStatusLogOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Status', false);
    return prefs.commit();
  }

  Future<bool> ifLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('Status');
  }
}