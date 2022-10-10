import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class InfoService extends ApiConnectProvider {
  @override
  String get api => 'info';

  Future<Response> getInfo(String infoname) {
    return get('auth/$api/byname', query: {
      'infoname': infoname,
    });
  }
}
