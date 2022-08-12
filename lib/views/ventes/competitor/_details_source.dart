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
    super.onClose();
  }
}
