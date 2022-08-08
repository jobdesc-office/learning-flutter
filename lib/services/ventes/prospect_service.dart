import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/api_connect_provider.dart';

class ProspectService extends ApiConnectProvider {
  String get api => 'prospect';
  final box = GetStorage();

  Future<Response> datatablesbp(Map<String, dynamic> params) {
    return post('$api/datatables/${box.read('mybpid')}', params);
  }

  Future<Response> lastid() {
    return get('$api/lastid');
  }

  Future<Response> selectref(Map<String, dynamic> params) {
    return get('$api/selectref', query: params);
  }

  Future<Response> storeCustomer(
    dynamic body, {
    String? contentType,
  }) {
    return post('$api/customer', body, contentType: contentType);
  }

  Future<Response> storeProduct(Map<String, dynamic> body) {
    return post('$api/product', body);
  }
}
