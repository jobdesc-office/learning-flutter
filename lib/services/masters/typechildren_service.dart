import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class TypeChildrenService extends ApiConnectProvider {
  @override
  String get api => 'typeschildren';

  Future<Response> datatablesNonFilter(Map<String, dynamic> params) {
    return post('$api/datatables', params);
  }

  Future<Response> storerole(Map<String, dynamic> body) {
    return post('$api/role', body);
  }

  Future<Response> datatablesTypesChild(Map<String, dynamic> params, int id) {
    return post('$api/datatables/$id', params);
  }

  Future<Response> parent(Map<String, dynamic> params) {
    return get('$api/parent', query: params);
  }

  Future<Response> showParent(int id) {
    return get('$api/parent/$id');
  }

  Future<Response> children(Map<String, dynamic> params) {
    return get('$api/children', query: params);
  }
}
