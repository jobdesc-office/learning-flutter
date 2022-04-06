import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class TypeChildrenService extends ApiConnectProvider {
  @override
  String get api => 'typeschildren';

  Future<Response> datatablesTypesChild(Map<String, dynamic> params, int id) {
    return post('$api/datatables/$id', params);
  }

  Future<Response> parent() {
    return get('$api/parent');
  }
}
