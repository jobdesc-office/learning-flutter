import 'package:get/get.dart';

import '../../presenters/auth_presenter.dart';
import '../../utils/api_connect_provider.dart';

final authPresenter = Get.find<AuthPresenter>();

class CustomFieldService extends ApiConnectProvider {
  String get api => 'customfield';

  Future<Response> selectWithBp(Map<String, dynamic> params) {
    return post('$api/selectwithbp/${authPresenter.bpActiveId.value}', params);
  }

  Future<Response> selectBp(Map<String, dynamic> params) {
    return get('$api/select/${authPresenter.bpActiveId.value}', query: params);
  }
}
