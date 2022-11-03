import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../models/masters/user_model.dart';
import '../../../models/ventes/chat_model.dart';

Socket get socket => Get.find<Socket>();

class ChatSource extends GetxController {
  var chats = <ChatModel>[].obs;
  var users = <UserModel>[].obs;
  var useridactive = 0.obs;
  var usersocketactive = ''.obs;
  var isFile = false.obs;
  var pickedFile = Uint8List(123).obs;

  void onMessage(data) {
    List chat = data['chats'];
    if (data['from'] == socket.id) {
      // property.scheduleNotification();
      chats.value =
          chat.map<ChatModel>((item) => ChatModel.fromJson(item)).toList();
    } else {
      Map data = {
        'userid': useridactive.value,
        'to': usersocketactive.value,
      };
      socket.emit('readmessage', data);
    }
  }

  @override
  void onReady() {
    super.onReady();
    socket.on('message', onMessage);
  }

  @override
  void onClose() {
    chats.value = [];
    users.value = [];
    useridactive.value = 0;
    usersocketactive.value = '';
    super.onClose();
  }
}
