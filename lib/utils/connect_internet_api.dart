import 'package:get/get.dart';

import '../config.dart';

class ConnectInternetAPI extends GetConnect {
  Future<Response> timeZone() {
    return get('http://worldtimeapi.org/api/timezone', headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers':
          'Origin, Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token, locale',
      'Access-Control-Allow-Methods': 'GET, POST',
    });
  }

  Future<Response> timeZoneDetail(String zone) {
    return get('http://worldtimeapi.org/api/timezone/$zone', headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers':
          'Origin, Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token, locale',
      'Access-Control-Allow-Methods': 'GET, POST',
    });
  }

  Future<Response> address(String latitudelongitude) {
    return get('${Config.api}/address',
        query: {'latlng': latitudelongitude, 'apiKey': Config.googleApi});
  }
}
