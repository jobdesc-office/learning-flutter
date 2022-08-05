import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class FileService extends ApiConnectProvider {
  String get api => 'file';

  Future<Response> storeProspect(
    dynamic body, {
    String? contentType,
  }) {
    return post('$api/prospect', body, contentType: contentType);
  }
}
