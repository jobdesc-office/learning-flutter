import 'package:get/get.dart';

import '../models/session_model.dart';
import 'session_manager.dart';

class ApiConnectProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.addRequestModifier<dynamic>((request) async {
      SessionModel session = await SessionManager.current();
      if (session.jwtToken != null)
        request.headers['Authorization'] = "Bearer ${session.jwtToken}";

      request.headers['api-key'] = "123456";
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
  }
}
