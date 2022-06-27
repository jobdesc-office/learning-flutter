import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ProspectActivityService extends ApiConnectProvider {
  String get api => 'prospectactivity';

  Future<Response> prospectDetails(Map<String, dynamic> params) {
    return post('$api/details', params);
  }
}
