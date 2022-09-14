import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ProductService extends ApiConnectProvider {
  @override
  String get api => 'product';

  Future<Response> selectWithBp(Map<String, dynamic> params, id) {
    return get('$api/select/$id', query: params);
  }

  Future<Response> datatablesbp(Map<String, dynamic> params) {
    return post('$api/datatables/${box.read('mybpid')}', params);
  }
}
