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
import 'prospectlost/chat_ref.dart';

final userPresenter = Get.find<UserPresenter>();
final chatPresenter = Get.find<ChatPresenter>();
final box = GetStorage();
final source = Get.put(ChatSource());

// ignore: must_be_immutable
class ChatView extends GetView implements ChatContract {
  // final presenter = Get.find<CityPresenter>();
  late Response users;

  ChatView() {
    userPresenter.chatDataContract = this;
    chatPresenter.chatViewContract = this;
  }

  final authPresenter = Get.find<AuthPresenter>();
  final _navigation = Get.find<NavigationPresenter>();

  TextEditingController inputChat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userPresenter.samebp(context);
    // ignore: invalid_use_of_protected_member
    // var permis = authPresenter.rolepermis.value;
    var text = false.obs;
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
                BsCol(
                  // height: MediaQuery.of(context).size.height * 0.8,
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
                  sizes: ColScreen(sm: Col.col_2),
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.79),
                    child: SingleChildScrollView(
                      child: Column(
                        children: source.users
                            .map((e) => InkWell(
                                  onTap: () {
                                    source.chats.clear();
                                    source.useridactive.value = e.userid ?? 0;
                                    source.usersocketactive.value =
                                        e.usersocketid ?? '';

                                    chatPresenter.conversation(
                                        context, source.useridactive.value);
                                  },
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                          width: 3.0,
                                          // assign the color to the border color
                                          color: _navigation.darkTheme.value
                                              ? source.useridactive.value ==
                                                      e.userid
                                                  ? ColorPallates.secondary
                                                  : Color(0xff454D55)
                                              : source.useridactive.value ==
                                                      e.userid
                                                  ? ColorPallates.primary
                                                  : Color(0xfff1f1f1),
                                        )),
                                    padding: EdgeInsets.all(3),
                                    margin: EdgeInsets.all(10),
                                    child: BsRow(
                                      children: [
                                        BsCol(
                                            sizes: ColScreen(sm: Col.col_4),
                                            child: Icon(
                                              Icons.person,
                                              size: 42,
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
                                                  color: _navigation
                                                          .darkTheme.value
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
                    ),
                  ),
                ),
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
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: SingleChildScrollView(
                                child: BsRow(
                                  children: source.chats
                                      .map((e) => BsCol(
                                            margin: EdgeInsets.all(5),
                                            alignment:
                                                e.createdby == box.read('id')
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.5),
                                              decoration: BoxDecoration(
                                                  color: _navigation
                                                          .darkTheme.value
                                                      ? e.createdby ==
                                                              box.read('id')
                                                          ? ColorPallates
                                                              .secondary
                                                          : Color(0xff454D55)
                                                      : e.createdby ==
                                                              box.read('id')
                                                          ? ColorPallates
                                                              .primary
                                                          : Color(0xfff1f1f1),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: EdgeInsets.all(3),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (e.chatrefid != null)
                                                    if (e.chatreftype!
                                                            .typename ==
                                                        'Prospect')
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: _navigation
                                                                      .darkTheme
                                                                      .value
                                                                  ? e.chatmessage !=
                                                                          null
                                                                      ? Color(
                                                                          0xff454D55)
                                                                      : Colors
                                                                          .transparent
                                                                  : e.chatmessage !=
                                                                          null
                                                                      ? Color(
                                                                          0xfff1f1f1)
                                                                      : Colors
                                                                          .transparent),
                                                        ),
                                                        child: BsRow(
                                                          children: [
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_4),
                                                              child: Container(
                                                                child: Text(
                                                                  'Prospect Name',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_1),
                                                              child: Container(
                                                                child: Text(':',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_7),
                                                              child: Container(
                                                                child: Text(
                                                                    e.refprospect
                                                                            ?.prospectname ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_4),
                                                              child: Container(
                                                                child: Text(
                                                                  'Customer Name',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_1),
                                                              child: Container(
                                                                child: Text(':',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_7),
                                                              child: Container(
                                                                child: Text(
                                                                    e.refprospect?.prospectcust
                                                                            ?.sbccstmname ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_4),
                                                              child: Container(
                                                                child: Text(
                                                                  'Start Date',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_1),
                                                              child: Container(
                                                                child: Text(':',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_7),
                                                              child: Container(
                                                                child: Text(
                                                                    e.refprospect
                                                                            ?.prospectstartdate ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    else
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: _navigation
                                                                      .darkTheme
                                                                      .value
                                                                  ? e.chatmessage !=
                                                                          null
                                                                      ? Color(
                                                                          0xff454D55)
                                                                      : Colors
                                                                          .transparent
                                                                  : e.chatmessage !=
                                                                          null
                                                                      ? Color(
                                                                          0xfff1f1f1)
                                                                      : Colors
                                                                          .transparent),
                                                        ),
                                                        child: BsRow(
                                                          children: [
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_4),
                                                              child: Container(
                                                                child: Text(
                                                                    'Person',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_1),
                                                              child: Container(
                                                                child: Text(':',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_7),
                                                              child: Container(
                                                                child: Text(
                                                                    e.refactivity?.dayactuser
                                                                            ?.userfullname ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_4),
                                                              child: Container(
                                                                child: Text(
                                                                    'Date',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_1),
                                                              child: Container(
                                                                child: Text(':',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_7),
                                                              child: Container(
                                                                child: Text(
                                                                    e.refactivity
                                                                            ?.dayactdate ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_4),
                                                              child: Container(
                                                                child: Text(
                                                                    'Category',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_1),
                                                              child: Container(
                                                                child: Text(':',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_7),
                                                              child: Container(
                                                                child: Text(
                                                                    e.refactivity?.dayactcat
                                                                            ?.sbttypename ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_4),
                                                              child: Container(
                                                                child: Text(
                                                                    'Location',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_1),
                                                              child: Container(
                                                                child: Text(':',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            BsCol(
                                                              sizes: ColScreen(
                                                                  sm: Col
                                                                      .col_7),
                                                              child: Container(
                                                                child: Tooltip(
                                                                  message:
                                                                      'Tap to Copy',
                                                                  child:
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Clipboard.setData(
                                                                              ClipboardData(text: e.refactivity?.dayactloc ?? ''),
                                                                            );
                                                                            Snackbar().copySuccess();
                                                                          },
                                                                          child: Text(
                                                                              e.refactivity?.dayactloc ?? '',
                                                                              style: TextStyle(color: Colors.white))),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  if (e.chatfile != null)
                                                    if (e.chatfile!.filename!
                                                            .substring(e
                                                                    .chatfile!
                                                                    .filename!
                                                                    .length -
                                                                4) !=
                                                        '.pdf')
                                                      Image.network(
                                                          e.chatfile!.url!)
                                                    else
                                                      Container(
                                                        constraints: BoxConstraints(
                                                            maxWidth: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Icon(
                                                                FontAwesomeIcons
                                                                    .filePdf),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () => chatPresenter
                                                                      .viewFile(e
                                                                          .chatfile!
                                                                          .url!),
                                                                  child: Icon(Icons
                                                                      .visibility),
                                                                ),
                                                                InkWell(
                                                                  onTap: () => chatPresenter
                                                                      .downloadFile(e
                                                                          .chatfile!
                                                                          .url!),
                                                                  child: Icon(Icons
                                                                      .download),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                  if (e.chatmessage != null)
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              5, 2, 0, 2),
                                                      child: Text(
                                                        e.chatmessage ?? '',
                                                        style: TextStyle(
                                                          color: _navigation
                                                                  .darkTheme
                                                                  .value
                                                              ? Colors.white
                                                              : e.createdby ==
                                                                      box.read(
                                                                          'id')
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      ),
                                                    ),
                                                ],
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
                                        InkWell(
                                          onTap: () => showDialog(
                                            context: context,
                                            builder: (context) => ChatRef(),
                                          ),
                                          child: Icon(
                                            Icons.analytics,
                                            size: 32,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'jpeg',
                                                'jpg',
                                                'pdf',
                                                'png',
                                                'gif'
                                              ],
                                            );
                                            if (result != null) {
                                              Uint8List pickedFile =
                                                  result.files.single.bytes!;
                                              source.pickedFile.value =
                                                  pickedFile;
                                              source.isFile.value = true;
                                              if (result.files.single.name
                                                      .substring(result
                                                              .files
                                                              .single
                                                              .name
                                                              .length -
                                                          4) ==
                                                  '.pdf') {
                                                source.isDocument.value = true;
                                              }
                                            }
                                          },
                                          child: Icon(
                                            Icons.file_copy,
                                            size: 32,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (source.useridactive.value != 0)
                                  BsCol(
                                    margin: EdgeInsets.only(
                                        left: 5,
                                        right: text.value ||
                                                source.isFile.value ||
                                                source.name.value != ''
                                            ? 5
                                            : 20),
                                    sizes: ColScreen(
                                        sm: text.value ||
                                                source.isFile.value ||
                                                source.name.value != ''
                                            ? Col.col_10
                                            : Col.col_11),
                                    child: CustomInput(
                                      maxLines: 1,
                                      autofocus: true,
                                      controller: inputChat,
                                      onChange: (value) =>
                                          text.value = value != '',
                                      onFieldSubmitted: (value) =>
                                          onClickSendMessages(),
                                    ),
                                  ),
                                if (text.value ||
                                    source.isFile.value ||
                                    source.name.value != '')
                                  BsCol(
                                    margin: EdgeInsets.only(left: 5),
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: InkWell(
                                      onTap: () => onClickSendMessages(),
                                      child: CircleAvatar(
                                        radius: 25,
                                        child: Icon(Icons.send),
                                        backgroundColor: ColorPallates.primary,
                                      ),
                                    ),
                                  )
                              ],
                            ),
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

  void onClickSendMessages() {
    chatPresenter.initiateMessage(inputChat.text, source.useridactive.value,
        source.usersocketactive.value,
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
