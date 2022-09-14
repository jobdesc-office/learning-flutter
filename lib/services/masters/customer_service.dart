import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class CustomerService extends ApiConnectProvider {
  String get api => 'customer';

  Future<Response> storeCustomer(
    dynamic body, {
    String? contentType,
  }) {
    return post('$api/customer', body, contentType: contentType);
  }
}
