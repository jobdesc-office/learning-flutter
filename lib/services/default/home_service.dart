import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class HomeService extends ApiConnectProvider {
  @override
  String get api => 'home';

  // Future<Response> index(int id) {
  //   return get('$api/$id');
  // }

  Future<Response> byCust(
      {Map<String, dynamic> params = const {}, String order = 'asc'}) {
    return get('$api/bycust/${box.read('mybpid').toString()}',
        query: params, headers: {'order': order});
  }

  Future<Response> byCustLabel({Map<String, dynamic> params = const {}}) {
    return get('$api/bycustlabel/${box.read('mybpid').toString()}',
        query: params);
  }

  Future<Response> byStatus({Map<String, dynamic> params = const {}}) {
    return get('$api/bystatus/${box.read('mybpid').toString()}', query: params);
  }

  Future<Response> byStage(
      {Map<String, dynamic> params = const {}, String order = 'asc'}) {
    return get('$api/bystage/${box.read('mybpid').toString()}',
        query: params, headers: {'order': order});
  }
}
