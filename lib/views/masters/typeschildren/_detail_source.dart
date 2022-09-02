import 'package:get/get.dart';

class TypeChildrenDetailsSource extends GetxController {
  var code = ''.obs;
  var name = ''.obs;
  var parent = ''.obs;
  var desc = ''.obs;
  var seq = ''.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    code.value = '';
    name.value = '';
    parent.value = '';
    desc.value = '';
    seq.value = '';

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
