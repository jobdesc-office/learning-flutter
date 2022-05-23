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
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitudelongitude&key=AIzaSyDUYfxm7qJq8dcMMhvhaoUukhQqMxBO6oc');
  }
}
