import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class ContactService extends ApiConnectProvider {
  String get api => 'contact';

  Future<Response> massStore(Map<String, dynamic> body) {
    return post('$api/massStore', body);
  }
}
