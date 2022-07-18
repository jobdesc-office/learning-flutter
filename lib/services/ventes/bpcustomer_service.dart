import 'package:get/get.dart';

import '../../presenters/auth_presenter.dart';
import '../../utils/api_connect_provider.dart';

class BpCustomerService extends ApiConnectProvider {
  final authPresenter = Get.find<AuthPresenter>();
  String get api => 'bpcustomer';

  Future<Response> selectBp(Map<String, dynamic> params) {
    return get('$api/select/${authPresenter.bpActiveId.value}', query: params);
  }

  Future<Response> storeBpCustomer(
    dynamic body, {
    String? contentType,
  }) {
    return post(api, body, contentType: contentType);
  }

  Future<Response> updateBpCustomer(
    int id,
    dynamic body, {
    String? contentType,
  }) {
    return put('$api/$id', body);
  }
}
