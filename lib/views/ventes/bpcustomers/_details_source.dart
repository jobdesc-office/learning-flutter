import 'package:get/get.dart';

class BpCustomerDetailsSource extends GetxController {
  var name = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var type = ''.obs;
  var pic = ''.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    name.value = '';
    phone.value = '';
    address.value = '';
    type.value = '';
    pic.value = '';

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
