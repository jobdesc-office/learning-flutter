import 'package:get/get.dart';

class BpCustomerDetailsSource extends GetxController {
  var name = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var type = ''.obs;
  var pic = ''.obs;

  @override
  void onClose() {
    name.value = '';
    phone.value = '';
    address.value = '';
    type.value = '';
    pic.value = '';
    super.onClose();
  }
}
