import 'package:get/get.dart';

class SecurityGroupDetailsSource extends GetxController {
  var name = ''.obs;
  var cd = ''.obs;
  var parent = ''.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    name.value = '';
    cd.value = '';
    parent.value = '';

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
