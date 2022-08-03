import 'package:boilerplate/presenters/auth_presenter.dart';
import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ReportService extends ApiConnectProvider {
  String get api => 'dailyactivity';

  final authPresenter = Get.find<AuthPresenter>();

  Future<Response> bpid(int id) {
    return get('$api/bp/$id');
  }
}
