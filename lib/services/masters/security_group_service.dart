import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class SecurityGroupService extends ApiConnectProvider {
  @override
  String get api => 'securitygroup';

  Future<Response> datatable(Map<String, dynamic> params) {
    int bpid = box.read('mybpid');
    return post('$api/datatables', {
      ...params,
      'sgbpid': bpid,
    });
  }

  Future<Response> getAll(Map<String, dynamic> params) {
    int bpid = box.read('mybpid');
    return get('$api/all', query: {
      ...params,
      'sgbpid': bpid.toString(),
    });
  }

  Future<Response> byCodeMaster(String sgcode) {
    return get('$api/by-codemaster', query: {'sgcode': sgcode});
  }

  Future<Response> byCode(String sgcode) {
    return get('$api/by-code', query: {'sgcode': sgcode});
  }

  Future<Response> byCodeAdd(Map<String, dynamic> params) {
    return get('$api/by-code-add', query: params);
  }
}
