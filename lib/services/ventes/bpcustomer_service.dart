import 'package:get/get.dart';

import '../../presenters/auth_presenter.dart';
import '../../utils/api_connect_provider.dart';

class BpCustomerService extends ApiConnectProvider {
  final authPresenter = Get.find<AuthPresenter>();
  String get api => 'bpcustomer';

  Future<Response> selectBp(Map<String, dynamic> params) {
    return get('$api/select/${authPresenter.bpActiveId.value}', query: params);
  }
}
