import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ScheduleService extends ApiConnectProvider {
  String get api => 'schedule';

  Future<Response> all() {
    return get('$api');
  }
}
