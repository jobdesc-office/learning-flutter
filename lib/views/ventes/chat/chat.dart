import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/input/custom_input.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/city_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_text.dart';

class ChatView extends GetView {
  // final presenter = Get.find<CityPresenter>();

  final authPresenter = Get.find<AuthPresenter>();
  final _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    TextEditingController inputChat = TextEditingController();
    var text = false.obs;
    List<String> user = [
      'Novan',
      'Andre',
      'Andriansyah',
      'Putra',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A',
      'A'
    ];

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
              child: SingleChildScrollView(
                child: Column(
                  children: user
                      .map((e) => Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Icon(Icons.person)),
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_8),
                                  child: Column(
                                    children: [Text(e), Text('Online')],
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
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
              child: Column(
                children: [
                  Obx(() => Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.72,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        padding: EdgeInsets.all(3),
                                        child: Text(
                                          e['chat'],
                                          style: TextStyle(
                                            color: e['you']
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      )),
                  Obx(() => BsRow(
                        margin: EdgeInsets.only(top: 10),
                        children: [
                          BsCol(
                            margin: EdgeInsets.only(left: 5),
                            sizes: ColScreen(sm: Col.col_1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                onTap: () => Get.snackbar('Chat', 'message'),
                                child: CircleAvatar(
                                  radius: 25,
                                  child: Icon(Icons.send),
                                  backgroundColor: ColorPallates.primary,
                                ),
                              ),
                            )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
