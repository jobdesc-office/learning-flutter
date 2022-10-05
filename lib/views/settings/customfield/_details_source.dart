import 'package:get/get.dart';

class CustomFieldDetailsSource extends GetxController {
  var name = ''.obs;
  var bp = ''.obs;
  var type = ''.obs;
  var ref = ''.obs;
  var isvisible = false.obs;
  var newprospect = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    name.value = '';
    bp.value = '';
    type.value = '';
    isvisible.value = false;
    newprospect.value = false;

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
