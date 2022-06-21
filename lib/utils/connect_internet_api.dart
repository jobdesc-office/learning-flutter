import 'package:get/get.dart';

class ConnectInternetAPI extends GetConnect {
  Future<Response> timeZone() {
    return get('http://worldtimeapi.org/api/timezone');
  }

  Future<Response> timeZoneDetail(String zone) {
    return get('http://worldtimeapi.org/api/timezone/$zone');
  }

  Future<Response> address(String latitudelongitude) {
    return get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitudelongitude&key=AIzaSyDUYfxm7qJq8dcMMhvhaoUukhQqMxBO6oc',
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token, locale',
          'Access-Control-Allow-Methods': 'GET, POST',
        });
  }
}
