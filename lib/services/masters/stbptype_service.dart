import 'package:boilerplate/constants/config_types.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class StBpTypeService extends ApiConnectProvider {
  @override
  String get api => 'stbptype';

  Future<Response> datatable(int typeid) {
    Map<String, dynamic> params = {};
    int bpid = box.read('mybpid');
    return post('$api/datatables', params,
        query: {'typeid': '$typeid', 'bpid': '$bpid'});
  }
}
