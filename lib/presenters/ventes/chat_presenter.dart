import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../constants/base_text.dart';
import '../../contracts/ventes/chat_contract.dart';
import '../../models/ventes/chat_model.dart';
import '../../services/ventes/chat_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/snackbar.dart';

class ChatPresenter extends CustomGetXController {
  final _chatService = Get.find<ChatService>();
  Socket get socket => Get.find<Socket>();
  final box = GetStorage();

  late ChatContract _chatViewContract;
  set chatViewContract(ChatContract chatViewContract) {
    _chatViewContract = chatViewContract;
  }

  Future conversation(BuildContext context, int receiverid) async {
    Response response = await _chatService.conversation(receiverid);
    if (response.statusCode == 200)
      _chatViewContract.onLoadChats(context, response);
  }

  void initiateMessage(String messages, int receiverid, String receiversocket,
      {file}) async {
    ChatModel chat = ChatModel(
        chatbpid: box.read('mybpid'),
        chatmessage: messages,
        chatreceiverid: receiverid);

    Map<String, dynamic> data = {
      "to": receiversocket,
      'chat': chat.toJson(),
    };

    // if (property.selectedProspect != null) {
    //   data['chat']['chatreftypeid'] = dataSource.refTypes.firstWhereOrNull((element) => element.typename == "Prospect")?.typeid;
    //   data['chat']['chatrefid'] = property.selectedProspect?.prospectid;
    // }

    if (file != null) {
      data['chat']['chatfile'] = await file;
      sendMessage(data, binary: true);
    } else {
      sendMessage(data);
    }
  }

  void sendMessage(Map<String, dynamic> data, {bool binary = false}) {
    if (binary) {
      socket.emitWithAck('message', data, binary: true);
    } else {
      socket.emit('message', data);
    }
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    await _chatService.store(body);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    await _chatService.update(id, body);
  }

  void delete(BuildContext context, int typeid, String name, int index) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _chatService.destroy(typeid);
            if (response.statusCode == 200) {
              Snackbar().deleteSuccess(context);
              Navigator.pop(context);
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
