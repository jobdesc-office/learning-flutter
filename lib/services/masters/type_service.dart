import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class TypeService extends ApiConnectProvider {
  @override
  String get api => 'types';

  Future<Response> byCode(String typecd) {
    return get('$api/by-code', query: {'typecd': typecd});
  }
}
