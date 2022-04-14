import 'package:get/get.dart';

import '../config.dart';
import '../models/session_model.dart';

import 'session_manager.dart';

class ConnectInternetAPI extends GetConnect {
  Future<Response> TimeZone() {
    return get('http://worldtimeapi.org/api/timezone');
  }
}
