import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/api_connect_provider.dart';

class ScheduleService extends ApiConnectProvider {
  String get api => 'schedule';
  final box = GetStorage();

  Future<Response> all() {
    return get('$api/bp/${box.read('mybpid')}');
  }
}
