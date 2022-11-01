import 'package:get/get.dart';

import '../../../models/masters/user_model.dart';

class ChatSource extends GetxController {
  var users = <UserModel>[].obs;
  var useridactive = 0.obs;

  @override
  void onClose() {
    users.value = [];
    useridactive.value = 0;
    super.onClose();
  }
}
