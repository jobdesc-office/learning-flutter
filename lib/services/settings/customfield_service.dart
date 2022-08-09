import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../presenters/auth_presenter.dart';
import '../../utils/api_connect_provider.dart';

final authPresenter = Get.find<AuthPresenter>();
final box = GetStorage();

class CustomFieldService extends ApiConnectProvider {
  String get api => 'customfield';

  Future<Response> datatablesbp(Map<String, dynamic> params) {
    return post('$api/datatables/${box.read('mybpid')}', params);
  }

  Future<Response> selectWithBp(Map<String, dynamic> params) {
    return post('$api/selectwithbp/${box.read('mybpid')}', params);
  }

  Future<Response> withBp() {
    return get('$api/withbp/${box.read('mybpid')}');
  }

  Future<Response> selectBp(Map<String, dynamic> params) {
    return get('$api/select/${box.read('mybpid')}', query: params);
  }
}
