import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class UserService extends ApiConnectProvider {
  String get api => 'user';

  Future<Response> select2(Map<String, dynamic> params) {
    return get('$api/select2', query: params);
  }
}
