import 'package:boilerplate/contracts/ventes/chat_contract.dart';
import 'package:boilerplate/models/masters/user_model.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/input/custom_input.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/city_presenter.dart';
import '../../../presenters/masters/user_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_chat_source.dart';
import '_text.dart';

final userPresenter = Get.find<UserPresenter>();
final source = Get.put(ChatSource());

class ChatView extends GetView implements ChatContract {
  // final presenter = Get.find<CityPresenter>();
  late Response users;

  ChatView() {
    userPresenter.chatDataContract = this;
  }

  final authPresenter = Get.find<AuthPresenter>();
  final _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    userPresenter.samebp(context);
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    TextEditingController inputChat = TextEditingController();
    var text = false.obs;

    List<Map<String, dynamic>> chat = [
      {
        'chat':
            'Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat':
            'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat':
            'Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat':
            'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat':
            'Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat':
            'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat': 'Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat': 'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat': 'Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat': 'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat': 'Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat': 'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat': 'Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat': 'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat': 'Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat': 'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat': 'Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat': 'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      },
      {
        'chat': 'Hallo Hallo Hallo Hallo Hallo',
        'you': true,
      },
      {
        'chat': 'Hi Hi Hi Hi Hi Hi Hi Hi Hi Hi',
        'you': false,
      }
    ];

    return Scaffold(
      body: TemplateView(
        title: 'Chat',
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Chat', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesChat.index],
        background: true,
        child: BsRow(
          height: MediaQuery.of(context).size.height * 0.8,
          children: [
            BsCol(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  width: 5.0,
                  // assign the color to the border color
                  color: Color(0xfff1f1f1),
                ),
              ),
              sizes: ColScreen(sm: Col.col_2),
              child: Obx(() => SingleChildScrollView(
                    child: Column(
                      children: source.users
                          .map((e) => InkWell(
                                onTap: () =>
                                    source.useridactive.value = e.userid ?? 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _navigation.darkTheme.value
                                          ? source.useridactive.value ==
                                                  e.userid
                                              ? ColorPallates.secondary
                                              : Color(0xff454D55)
                                          : source.useridactive.value ==
                                                  e.userid
                                              ? ColorPallates.primary
                                              : null,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  padding: EdgeInsets.all(3),
                                  margin: EdgeInsets.all(10),
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_4),
                                          child: Icon(
                                            Icons.person,
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : source.useridactive.value ==
                                                        e.userid
                                                    ? Colors.white
                                                    : source.useridactive
                                                                .value ==
                                                            e.userid
                                                        ? Colors.white
                                                        : Colors.black,
                                          )),
                                      BsCol(
                                        sizes: ColScreen(sm: Col.col_8),
                                        child: Column(
                                          children: [
                                            Text(
                                              e.userfullname ?? '',
                                              style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : source.useridactive
                                                                    .value ==
                                                                e.userid
                                                            ? Colors.white
                                                            : Colors.black,
                                              ),
                                            ),
                                            Text('Online',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : source.useridactive
                                                                    .value ==
                                                                e.userid
                                                            ? Colors.white
                                                            : Colors.black))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )),
            ),
            BsCol(
              height: MediaQuery.of(context).size.height * 0.8,
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  width: 5.0,
                  // assign the color to the border color
                  color: Color(0xfff1f1f1),
                ),
              ),
              sizes: ColScreen(sm: Col.col_10),
              child: Obx(() => Column(
                    children: [
                      if (source.useridactive.value != 0)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: SingleChildScrollView(
                            child: BsRow(
                              children: chat
                                  .map((e) => BsCol(
                                        margin: EdgeInsets.all(5),
                                        alignment: e['you']
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: _navigation.darkTheme.value
                                                  ? e['you']
                                                      ? ColorPallates.secondary
                                                      : Color(0xff454D55)
                                                  : e['you']
                                                      ? ColorPallates.primary
                                                      : Color(0xfff1f1f1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            e['chat'],
                                            style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : e['you']
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
                            child: Text('Choose User'),
                          ),
                        ),
                      BsRow(
                        margin: EdgeInsets.only(top: 10),
                        children: [
                          if (source.useridactive.value != 0)
                            BsCol(
                              margin: EdgeInsets.only(left: 5),
                              sizes: ColScreen(sm: Col.col_1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.emoji_emotions,
                                    size: 32,
                                  ),
                                  Icon(
                                    Icons.file_copy,
                                    size: 32,
                                  ),
                                ],
                              ),
                            ),
                          if (source.useridactive.value != 0)
                            BsCol(
                              margin: EdgeInsets.only(
                                  left: 5, right: text.value ? 5 : 20),
                              sizes: ColScreen(
                                  sm: text.value ? Col.col_10 : Col.col_11),
                              child: CustomInput(
                                autofocus: true,
                                controller: inputChat,
                                onChange: (value) => text.value = value != '',
                              ),
                            ),
                          if (text.value)
                            BsCol(
                              margin: EdgeInsets.only(left: 5),
                              sizes: ColScreen(sm: Col.col_1),
                              child: InkWell(
                                onTap: () {
                                  Get.snackbar('Chat', 'message');
                                  inputChat.text = '';
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  child: Icon(Icons.send),
                                  backgroundColor: ColorPallates.primary,
                                ),
                              ),
                            )
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onLoadChats(BuildContext context, Response response) {
    // TODO: implement onLoadChats
  }

  @override
  void onLoadUsers(BuildContext context, Response response) {
    List<UserModel> users = [];

    for (var element in response.body) {
      users.add(UserModel.fromJson(element));
    }

    source.users.value = users;
  }
}
