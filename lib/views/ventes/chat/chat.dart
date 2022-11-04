import 'dart:typed_data';

import 'package:boilerplate/contracts/ventes/chat_contract.dart';
import 'package:boilerplate/models/masters/user_model.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/input/custom_input.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/ventes/chat_model.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/user_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/chat_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_chat_source.dart';
import 'chatreference/chat_ref.dart';

part 'chat_component/user_component.dart';
part 'chat_component/chat_component.dart';
part 'chat_component/input_component.dart';

final userPresenter = Get.find<UserPresenter>();
final chatPresenter = Get.find<ChatPresenter>();
final box = GetStorage();
final source = Get.put(ChatSource());

final _navigation = Get.find<NavigationPresenter>();

TextEditingController inputChat = TextEditingController();

var text = false.obs;

// ignore: must_be_immutable
class ChatView extends GetView implements ChatContract {
  // final presenter = Get.find<CityPresenter>();
  late Response users;

  ChatView() {
    userPresenter.chatDataContract = this;
    chatPresenter.chatViewContract = this;
  }

  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    userPresenter.samebp(context);
    // ignore: invalid_use_of_protected_member
    // var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: 'Chat',
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Chat', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesChat.index],
        background: true,
        child: Obx(() => BsRow(
              // height: MediaQuery.of(context).size.height * 0.8,
              children: [
                userComponent(context),
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(
                      width: 5.0,
                      // assign the color to the border color
                      color: _navigation.darkTheme.value
                          ? Color(0xff454D55)
                          : Color(0xfff1f1f1),
                    ),
                  ),
                  sizes: ColScreen(sm: Col.col_10),
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.79),
                    child: Column(
                      children: [
                        if (!source.isFile.value)
                          if (source.useridactive.value != 0 &&
                              source.chats.isNotEmpty)
                            chatComponent(context)
                          else
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Center(
                                child: Text(source.useridactive.value == 0
                                    ? 'Choose User'
                                    : 'Start Conversation'),
                              ),
                            )
                        else if (source.isDocument.value)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Icon(FontAwesomeIcons.file),
                          )
                        else
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Image.memory(source.pickedFile.value),
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (source.name.value != '')
                              Container(
                                height: 30,
                                color: _navigation.darkTheme.value
                                    ? ColorPallates.secondary
                                    : ColorPallates.primary,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${source.name.value} || ${source.personname.value}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          source.isProspect.value = false;
                                          source.isActivity.value = false;
                                          source.reftype.value = 0;
                                          source.name.value = '';
                                          source.personname.value = '';
                                        },
                                        child: Icon(Icons.close,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                            inputComponent(context),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  void onLoadChats(BuildContext context, Response response) {
    List<ChatModel> chats = [];

    for (var element in response.body) {
      chats.add(ChatModel.fromJson(element));
    }

    source.chats.value = chats;
  }

  @override
  void onLoadUsers(BuildContext context, Response response) {
    List<UserModel> users = [];

    for (var element in response.body) {
      users.add(UserModel.fromJson(element));
    }

    users.removeWhere((element) => element.userid == box.read('id'));

    source.users.value = users;
  }
}

void onClickSendMessages() {
  chatPresenter.initiateMessage(
      inputChat.text, source.useridactive.value, source.usersocketactive.value,
      file: source.isFile.value ? source.pickedFile.value : null,
      ref: source.isActivity.value || source.isProspect.value
          ? source.ref.value
          : null,
      reftype: source.isActivity.value || source.isProspect.value
          ? source.reftype.value
          : null);

  inputChat.clear();
  source.isFile.value = false;
  source.isDocument.value = false;
  source.isProspect.value = false;
  source.isActivity.value = false;
  source.reftype.value = 0;
  source.name.value = '';
  source.personname.value = '';
}
