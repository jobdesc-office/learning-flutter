import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class UserService extends ApiConnectProvider {
  String get api => 'user';

  Future<Response> selectsamebp(Map<String, dynamic> params, int id) {
    return get('$api/select/$id', query: params);
  }

  Future<Response> datatablesbp(Map<String, dynamic> params, int id) {
    return post('$api/datatables/$id', params);
  }

  Future<Response> session(int id) {
    return get('$api/session');
  }

  Future<Response> reset(int id) {
    return get('$api/reset/$id');
  }
}
