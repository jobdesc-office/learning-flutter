import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/api_connect_provider.dart';

class AppService extends ApiConnectProvider {
  final box = GetStorage();
  Future<Response> init() {
    return get('t2IF5xRe');
  }

  Future<Response> role() {
    return get('450905094', query: {'roleid': '${box.read('role')}'});
  }
}
