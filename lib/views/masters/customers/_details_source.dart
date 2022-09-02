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

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

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

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
