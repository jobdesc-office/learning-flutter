import 'package:get/get.dart';

class BusinessPartnerDetailsSource extends GetxController {
  var name = ''.obs;
  var type = ''.obs;
  var pic = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    name.value = '';
    type.value = '';
    pic.value = '';
    phone.value = '';
    email.value = '';
    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
