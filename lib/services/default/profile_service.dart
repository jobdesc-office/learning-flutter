import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ProfileService extends ApiConnectProvider {
  @override
  String get api => 'profile';

  Future<Response> profile(id) {
    return get('$api/$id');
  }
}
