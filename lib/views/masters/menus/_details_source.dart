import 'package:get/get.dart';

class MenuDetailsSource extends GetxController {
  var id = 0.obs;
  var type = ''.obs;
  var parent = ''.obs;
  var name = ''.obs;
  var icon = ''.obs;
  var route = ''.obs;
  var color = ''.obs;
  var sequence = ''.obs;

  @override
  void onClose() {
    id.value = 0;
    type.value = '';
    parent.value = '';
    name.value = '';
    icon.value = '';
    route.value = '';
    color.value = '';
    sequence.value = '';
    super.onClose();
  }
}
