import 'package:get/get.dart';

import '../../utils/api_connect_provider.dart';

class CompetitorService extends ApiConnectProvider {
  String get api => 'competitor';

  Future<Response> storeCompetitor(
    dynamic body, {
    String? contentType,
  }) {
    return post(api, body, contentType: contentType);
  }

  Future<Response> updateCompetitor(
    int id,
    dynamic body, {
    String? contentType,
  }) {
    return post('$api/$id', body);
  }
}
