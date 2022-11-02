import 'package:get/get.dart';

import '../../../models/masters/user_model.dart';
import '../../../models/ventes/chat_model.dart';

class ChatSource extends GetxController {
  var chats = <ChatModel>[].obs;
  var users = <UserModel>[].obs;
  var useridactive = 0.obs;
  var usersocketactive = ''.obs;

  @override
  void onClose() {
    chats.value = [];
    users.value = [];
    useridactive.value = 0;
    usersocketactive.value = '';
    super.onClose();
  }
}
