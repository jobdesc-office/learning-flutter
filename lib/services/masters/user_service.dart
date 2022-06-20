import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class UserService extends ApiConnectProvider {
  String get api => 'user';

  Future<Response> selectsamebp(Map<String, dynamic> params, int id) {
    return get('$api/select/$id', query: params);
  }

  Future<Response> session(int id) {
    return get('$api/session');
  }
}
