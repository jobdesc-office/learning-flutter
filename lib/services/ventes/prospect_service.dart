import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ProspectService extends ApiConnectProvider {
  String get api => 'prospect';

  Future<Response> lastid() {
    return get('$api/lastid');
  }
}
