import 'package:get/get.dart';

class ConnectInternetAPI extends GetConnect {
  Future<Response> timeZone() {
    return get('http://worldtimeapi.org/api/timezone');
  }

  Future<Response> timeZoneDetail(String zone) {
    return get('http://worldtimeapi.org/api/timezone/$zone');
  }
}
