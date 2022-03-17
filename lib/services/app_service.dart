import 'package:get/get.dart';

import '../utils/api_connect_provider.dart';

class AppService extends ApiConnectProvider {
  Future<Response> init() {
    return get('t2IF5xRe');
  }
}
