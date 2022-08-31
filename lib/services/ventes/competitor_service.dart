import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/api_connect_provider.dart';

class CompetitorService extends ApiConnectProvider {
  String get api => 'competitor';
  final box = GetStorage();

  Future<Response> datatablesbp(Map<String, dynamic> params) {
    return post('$api/datatables/${box.read('mybpid')}', params);
  }

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

  Future<Response> deleteImages({
    Map<String, dynamic>? query,
  }) {
    return post('$api/deleteimages', query);
  }
}
