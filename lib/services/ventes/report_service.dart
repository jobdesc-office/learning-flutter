import 'package:boilerplate/presenters/auth_presenter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/api_connect_provider.dart';

class ReportService extends ApiConnectProvider {
  String get api => 'dailyactivity';
  final box = GetStorage();

  final authPresenter = Get.find<AuthPresenter>();

  Future<Response> bpid(int id) {
    return get('$api/bp/$id');
  }

  Future<Response> datatablesbp(Map<String, dynamic> params) {
    return post('$api/datatables/${box.read('mybpid')}', params);
  }
}
