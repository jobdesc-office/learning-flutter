import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class FeatureService extends ApiConnectProvider {
  String get api => 'feature';

  Future<Response> datatablesMenu(int id, Map<String, dynamic> params) {
    return post('$api/datatables/$id', params);
  }
}
