import 'package:get/get.dart';

class ContactDetailsSource extends GetxController {
  var customer = ''.obs;
  var type = ''.obs;
  var name = ''.obs;
  var value = ''.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    customer.value = '';
    type.value = '';
    name.value = '';
    value.value = '';
    super.onClose();
  }
}
