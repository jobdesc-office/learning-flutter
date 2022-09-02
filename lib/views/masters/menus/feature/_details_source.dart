import 'package:get/get.dart';

class FeatureDetailsSource extends GetxController {
  var menu = ''.obs;
  var title = ''.obs;
  var slug = ''.obs;
  var desc = ''.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    menu.value = '';
    title.value = '';
    slug.value = '';
    desc.value = '';

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
