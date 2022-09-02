import 'package:get/get.dart';

class UserDetailsSource extends GetxController {
  var id = 0.obs;
  var name = ''.obs;
  var username = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var deviceid = '0'.obs;
  var type = ''.obs;
  var bp = ''.obs;
  var active = true.obs;
  var role = [].obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    id.value = 0;
    name.value = '';
    username.value = '';
    email.value = '';
    phone.value = '';
    deviceid.value = '';
    type.value = '';
    bp.value = '';
    active.value = true;
    role.value = [];

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
