import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ProspectDetailService extends ApiConnectProvider {
  String get api => 'prospectdetail';

  @override
  Future<Response> prospectDetails(Map<String, dynamic> params) {
    return post('$api/details', params);
  }
}
