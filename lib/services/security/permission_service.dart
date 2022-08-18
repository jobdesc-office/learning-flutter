import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class PermissionService extends ApiConnectProvider {
  String get api => 'permission';

  Future<Response> menu(int roleid) {
    return get('$api/menu', query: {'roleid': roleid.toString()});
  }

  Future<Response> permission(int roleid, int menuid) {
    return get('$api/permission',
        query: {'roleid': roleid.toString(), 'menuid': menuid.toString()});
  }
}
