import 'package:get/get.dart';

class TypeParentDetailsSource extends GetxController {
  var name = ''.obs;
  var cd = ''.obs;
  var desc = ''.obs;
  var seq = ''.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    name.value = '';
    cd.value = '';
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
