import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ProspectService extends ApiConnectProvider {
  String get api => 'prospect';

  Future<Response> lastid() {
    return get('$api/lastid');
  }

  Future<Response> selectref(Map<String, dynamic> params) {
    return get('$api/selectref', query: params);
  }

  Future<Response> storeCustomer(Map<String, dynamic> body) {
    return post('$api/customer', body);
  }
}
