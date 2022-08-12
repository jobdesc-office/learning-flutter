import 'package:get/get.dart';

class TypeParentDetailsSource extends GetxController {
  var name = ''.obs;
  var cd = ''.obs;
  var desc = ''.obs;
  var seq = ''.obs;

  @override
  void onClose() {
    name.value = '';
    cd.value = '';
    desc.value = '';
    seq.value = '';
    super.onClose();
  }
}
