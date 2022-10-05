import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class TypeService extends ApiConnectProvider {
  @override
  String get api => 'types';

  Future<Response> byCodeMaster(String typecd) {
    return get('$api/by-codemaster', query: {'typecd': typecd});
  }

  Future<Response> byCode(String typecd) {
    return get('$api/by-code', query: {'typecd': typecd});
  }

  Future<Response> byCodeAdd(Map<String, dynamic> params) {
    return get('$api/by-code-add', query: params);
  }

  Future<Response> bySeq(String typecd) {
    return get('$api/bySeq', query: {'typecd': typecd});
  }

  Future<Response> getAllRoles() {
    return get('$api/getAllRoles');
  }
}
