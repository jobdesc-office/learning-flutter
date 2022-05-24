import 'package:get/get.dart';

import '../config.dart';
import '../models/session_model.dart';

import 'session_manager.dart';

class ApiConnectProvider extends GetConnect {
  String get api => '';

  @override
  void onInit() {
    httpClient.baseUrl = Config.api;
    httpClient.addRequestModifier<dynamic>((request) async {
      SessionModel session = await SessionManager.current();
      if (session.jwtToken != null)
        request.headers['Authorization'] = "Bearer ${session.jwtToken}";

      request.headers['api-key'] = "123456";
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
  }

  Future<Response> index() {
    return get('$api/index');
  }

  Future<Response> select(Map<String, dynamic> params) {
    return get('$api/select', query: params);
  }

  Future<Response> all() {
    return get('$api/all');
  }

  Future<Response> datatables(Map<String, dynamic> params) {
    return post('$api/datatables', params);
  }

  Future<Response> store(Map<String, dynamic> body) {
    return post('$api', body);
  }

  Future<Response> show(int id) {
    return get('$api/$id');
  }

  Future<Response> update(int id, Map<String, dynamic> body) {
    return put('$api/$id', body);
  }

  Future<Response> destroy(int id, {Map<String, dynamic>? query}) {
    return delete('$api/$id', query: query);
  }

  Future<Response> byName(Map<String, dynamic> params) {
    return get('$api/by-name', query: params);
  }
}
