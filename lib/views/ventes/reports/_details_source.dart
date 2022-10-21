import 'package:get/get.dart';

import '../../../models/ventes/report_model.dart';

class ReportDetailsSource extends GetxController {
  var ref = ''.obs;
  var customer = ''.obs;
  var cat = ''.obs;
  var type = ''.obs;
  var typeval = ''.obs;
  var date = ''.obs;
  var desc = ''.obs;
  var loclab = ''.obs;
  var loc = ''.obs;
  var long = ''.obs;
  var lat = ''.obs;

  var cf = <Activitycustomfield>[].obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = false.obs;

  @override
  void onClose() {
    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;
    super.onClose();
  }
}
