import 'package:get/get.dart';

class mapSource extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var linkCoordinate = ''.obs;
  var latitudelongitude = ''.obs;

  reset() {
    latitude.value = 0.0;
    longitude.value = 0.0;
    linkCoordinate.value = '';
    latitudelongitude.value = '';
  }
}
