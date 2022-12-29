import 'package:get/get.dart';

import '../../../models/ventes/customfield_model.dart';

class CustomFieldDetailsSource extends GetxController {
  var name = ''.obs;
  var bp = ''.obs;
  var group = ''.obs;
  var type = ''.obs;
  var ref = ''.obs;
  var isvisible = false.obs;
  var newprospect = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  var isselectbox = false.obs;
  var selectbox = <Selectoption>[].obs;

  @override
  void onClose() {
    name.value = '';
    bp.value = '';
    group.value = '';
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
