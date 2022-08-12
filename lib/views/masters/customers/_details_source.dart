import 'package:get/get.dart';

class CustomerDetailsSource extends GetxController {
  var prefix = ''.obs;
  var name = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var type = ''.obs;
  var province = ''.obs;
  var city = ''.obs;
  var subdistrict = ''.obs;
  var muv = ''.obs;
  var postal = ''.obs;
  var latitude = ''.obs;
  var longitude = ''.obs;
  var referal = ''.obs;

  @override
  void onClose() {
    prefix.value = '';
    name.value = '';
    phone.value = '';
    address.value = '';
    type.value = '';
    province.value = '';
    city.value = '';
    subdistrict.value = '';
    muv.value = '';
    postal.value = '';
    latitude.value = '';
    longitude.value = '';
    referal.value = '';
    super.onClose();
  }
}
