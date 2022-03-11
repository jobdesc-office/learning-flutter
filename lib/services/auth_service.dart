import 'package:boilerplate/config.dart';
import 'package:get/get.dart';

import '../utils/api_connect_provider.dart';

class AuthService extends ApiConnectProvider {
  static String api = '${Config.api}/auth';

  Future<Response> verifyToken() {
    return get('${Config.api}/RJXvksjS');
  }

  Future<Response> signIn(String username, String password) {
    return post('$api/signin', {'username': username, 'password': password});
  }

  Future<Response> signOut() {
    return get('${Config.api}/pIeYujTv');
  }
}
