import 'package:get/get.dart';

class BusinessPartnerDetailsSource extends GetxController {
  var name = ''.obs;
  var type = ''.obs;
  var pic = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;

  @override
  void onClose() {
    name.value = '';
    type.value = '';
    pic.value = '';
    phone.value = '';
    email.value = '';
    super.onClose();
  }
}
