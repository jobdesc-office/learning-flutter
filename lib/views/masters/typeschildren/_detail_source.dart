import 'package:get/get.dart';

class TypeChildrenDetailsSource extends GetxController {
  var code = ''.obs;
  var name = ''.obs;
  var parent = ''.obs;
  var desc = ''.obs;
  var seq = ''.obs;

  @override
  void onClose() {
    code.value = '';
    name.value = '';
    parent.value = '';
    desc.value = '';
    seq.value = '';
    super.onClose();
  }
}
