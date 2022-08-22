import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/session_model.dart';

class SessionManager {
  static Future<bool> setLogin(SessionModel sessionModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('jwtToken', sessionModel.jwtToken!);
    sharedPreferences.setInt('userid', sessionModel.userid!);

    return isLogged();
  }

  static Future<SessionModel> current() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return SessionModel(
        jwtToken: sharedPreferences.getString('jwtToken'),
        userid: sharedPreferences.getInt('userid'));
  }

  static Future<bool> isLogged() async {
    SessionModel session = await current();
    return session.jwtToken != null;
  }

  static Future destroy() async {
    final box = GetStorage();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('jwtToken');
    sharedPreferences.remove('userid');
    box.remove('name');
    box.remove('id');
    box.remove('username');
    box.remove('details');
    box.remove('mybpid');
    box.remove('role');
  }
}
