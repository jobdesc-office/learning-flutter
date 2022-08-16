import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class PermissionService extends ApiConnectProvider {
  String get api => 'permission';

  Future<Response> datatablesMenu(int id, Map<String, dynamic> params) {
    return post('$api/datatables/$id', params);
  }
}
