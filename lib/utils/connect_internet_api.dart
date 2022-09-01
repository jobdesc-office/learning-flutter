import 'package:get/get.dart';

class ConnectInternetAPI extends GetConnect {
  Future<Response> timeZone() {
    return get(
        'https://cors-anywhere.herokuapp.com/http://worldtimeapi.org/api/timezone',
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token, locale',
          'Access-Control-Allow-Methods': 'GET, POST',
        });
  }

  Future<Response> timeZoneDetail(String zone) {
    return get(
        'https://cors-anywhere.herokuapp.com/http://worldtimeapi.org/api/timezone/$zone',
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token, locale',
          'Access-Control-Allow-Methods': 'GET, POST',
        });
  }

  Future<Response> address(String latitudelongitude) {
    return get(
        'https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitudelongitude&key=AIzaSyDUYfxm7qJq8dcMMhvhaoUukhQqMxBO6oc?language=id',
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token, locale',
          'Access-Control-Allow-Methods': 'GET, POST',
        });
  }
}
