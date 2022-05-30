import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class HomeService extends ApiConnectProvider {
  @override
  String get api => 'home';

  Future<Response> index(int id) {
    return get('$api/$id');
  }
}
