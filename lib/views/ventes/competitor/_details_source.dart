import 'package:get/get.dart';

class CompetitorDetailsSource extends GetxController {
  var name = ''.obs;
  var bp = ''.obs;
  var type = ''.obs;
  var desc = ''.obs;
  var product = ''.obs;
  var ref = ''.obs;
  var pic = [].obs;
  var title = [].obs;

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
    desc.value = '';
    product.value = '';
    ref.value = '';
    pic.value = [];
    title.value = [];

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
