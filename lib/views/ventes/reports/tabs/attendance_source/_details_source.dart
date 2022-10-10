import 'package:get/get.dart';

class AttendDetailsSource extends GetxController {
  var attdate = ''.obs;
  var attclockin = ''.obs;
  var attclockout = ''.obs;
  var attlat = ''.obs;
  var attlong = ''.obs;
  var attaddress = ''.obs;

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
