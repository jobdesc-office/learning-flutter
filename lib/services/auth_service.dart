import 'package:get/get.dart';

import '../utils/api_connect_provider.dart';

class AuthService extends ApiConnectProvider {
  String get api => 'auth';

  Future<Response> verifyToken() {
    return get('RJXvksjS');
  }

  Future<Response> signIn(String username, String password) {
    return post('$api/signin',
        {'username': username, 'password': password, 'source': 'web'});
  }

  Future<Response> signOut() {
    return get('pIeYujTv');
  }
}
