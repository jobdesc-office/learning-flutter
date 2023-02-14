import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/api_connect_provider.dart';

class MenuService extends ApiConnectProvider {
  String get api => 'menus';

  Future<Response> datatable(Map<String, dynamic> params, String type) {
    return get('$api/datatables', query: {'params': params, 'filter': type});
  }
}
